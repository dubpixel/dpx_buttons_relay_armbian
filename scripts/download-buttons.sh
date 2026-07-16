#!/usr/bin/env bash
# download-buttons.sh
# Downloads the Bitfocus Buttons USB Relay package from the repo's
# GitHub mirror release (tagged 'buttons-deb-mirror').
#
# No Bitfocus credentials needed — uses GITHUB_TOKEN (auto-injected in Actions).
#
# Outputs:
#   $ARTIFACTS_DIR/bitfocus-buttons-usb-relay-headless.deb
#   $ARTIFACTS_DIR/buttons-version.txt

set -euo pipefail

MIRROR_TAG="buttons-deb-mirror"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-artifacts}"

mkdir -p "$ARTIFACTS_DIR"

echo "==> Fetching package from mirror release: ${MIRROR_TAG}"

# Primary: gh release download (simple, standard)
# Fallback: gh api /releases list + curl direct URL
# The fallback avoids the /releases/tags/{tag} endpoint which can be flaky.

TARBALL=""

for attempt in 1 2 3 4 5; do
    echo "==> Download attempt ${attempt}/5"

    # Primary: gh release download
    if gh release download "$MIRROR_TAG" \
        --repo "${GITHUB_REPOSITORY}" \
        --pattern "*.tar.gz" \
        --dir "$ARTIFACTS_DIR" \
        --clobber 2>/dev/null; then
        TARBALL=$(ls "$ARTIFACTS_DIR"/*.tar.gz | head -1)
        break
    fi

    # Fallback: list endpoint → browser_download_url → curl
    echo "==> Primary failed, trying list API fallback..."
    ASSET_URL=$(gh api "repos/${GITHUB_REPOSITORY}/releases" \
        --jq ".[] | select(.tag_name == \"${MIRROR_TAG}\") | .assets[] | select(.name | endswith(\".tar.gz\")) | .browser_download_url" \
        2>/dev/null | head -1 || true)

    if [[ -n "$ASSET_URL" ]]; then
        OUTFILE="$ARTIFACTS_DIR/$(basename "$ASSET_URL")"
        if curl -fsSL -H "Authorization: Bearer ${GH_TOKEN}" \
                --retry 3 --retry-delay 5 \
                "$ASSET_URL" -o "$OUTFILE"; then
            TARBALL="$OUTFILE"
            break
        fi
    fi

    if [[ $attempt -eq 5 ]]; then
        echo "ERROR: Failed to download after 5 attempts"
        exit 1
    fi
    echo "==> Retrying in 20s..."
    sleep 20
done

if [[ -z "$TARBALL" || ! -f "$TARBALL" ]]; then
    TARBALL=$(ls "$ARTIFACTS_DIR"/*.tar.gz 2>/dev/null | head -1)
fi
TARBALL=$(ls "$ARTIFACTS_DIR"/*.tar.gz | head -1)
echo "==> Downloaded: $(basename "$TARBALL") ($(du -sh "$TARBALL" | cut -f1))"

# Parse version from filename:
#   bitfocus-buttons-usb-relay-headless_0.1.0-beta.4_arm64.tar.gz -> 0.1.0-beta.4
VERSION=$(basename "$TARBALL" _arm64.tar.gz | sed 's/.*_//')
echo "==> Version: ${VERSION}"

# Extract the .deb from the tarball (one level of directory nesting)
TMPEXTRACT=$(mktemp -d)
tar -xzf "$TARBALL" -C "$TMPEXTRACT"
DEB=$(find "$TMPEXTRACT" -name "*.deb" | head -1)

if [[ -z "$DEB" ]]; then
    echo "ERROR: No .deb found inside $(basename "$TARBALL")"
    exit 1
fi

echo "==> Extracted: $(basename "$DEB")"

# Normalize to a fixed name so Packer always finds it at the same path
cp "$DEB" "$ARTIFACTS_DIR/bitfocus-buttons-usb-relay-headless.deb"
rm -rf "$TMPEXTRACT" "$TARBALL"

echo "$VERSION" > "$ARTIFACTS_DIR/buttons-version.txt"
echo "==> Done — artifacts/buttons-version.txt: ${VERSION}"
