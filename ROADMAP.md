# dpx-buttnode Roadmap

Loose collection of planned improvements and ideas. Not a commitment, not a schedule — just a living list.

---

## Discovery & Setup UX

### `/label` — Self-Printed QR Label Page
**Status:** planned — `- [ ]`

Each buttnode already knows its own hostname (`dpx-buttnode-XXXX.local`) at runtime via Avahi/mDNS. The problem is you can't pre-print a label before first boot because the hostname is MAC-derived.

**Solution:** Add a `/label` route to `dpx-buttnode-ui.py` that renders a clean printable page containing:
- A QR code pointing to `http://dpx-buttnode-XXXX.local:8080`
- The `.local` URL printed in large text below it
- A print button (hides chrome, triggers `window.print()`)

Workflow: boot the unit → open its IP in a browser → go to `/label` → print → stick on box.

No external libraries needed. A pure-JS QR generator (e.g. `qrcode.js` inlined) handles the QR client-side.

---

### Network Discovery Page
**Status:** partially done — Nodes tab shipped in v0.5.0 (LAN discovery via web UI); full server-side subnet scan still `- [ ]`

From any buttnode's web UI, show all other buttnodes visible on the local network. Server-side subnet scan (ARP table or `avahi-browse`) so there are no browser security restrictions. Rendered as a list of clickable links.

---

## General

- [ ] First-boot wizard (hostname confirmation, mode selection: Buttons vs Satellite)
- [ ] `/status` JSON endpoint for scripting/monitoring

