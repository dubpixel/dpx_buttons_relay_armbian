<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!--  *** Thanks for checking out the Best-README-Template. If you have a suggestion that would make this better, please fork the repo and create a pull request or simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again! Now go create something AMAZING! :D -->



<!-- /// d   u   b   p   i   x   e   l  ---  f   o   r   k   ////--v0.5.7 -->
<!--this has additionally been modifed by @dubpixel for hardware use -->
<!--search dpx_buttons_armbian.. search & replace is COMMAND OPTION F -->

<!--this is the version for software -->
<!--todo ** add small product image thats not in a details tag -->
<!--todo ** new software product image? Remove it? -->
<!--igure out how to get the details tag to properly render in jekyll for gihub pages.-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
***
-->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
</div>
<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/dubpixel/dpx_buttons_armbian">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>
<h1 align="center">dpx_buttons_armbian</h1>
<h3 align="center"><i>Flash-ready Armbian images with Bitfocus Buttons USB Relay pre-installed</i></h3>
  <p align="center">
    Automated GitHub Actions build pipeline that produces ready-to-flash <code>.img.gz</code> images
    for ARM single-board computers (Orange Pi Zero, etc.) with
    <a href="https://bitfocus.io/buttons">Bitfocus Buttons USB Relay</a> pre-installed and auto-starting on boot.
    Write the image, plug in your Stream Deck, power on — done.
    <br /><br />
     »  
     <a href="https://github.com/dubpixel/dpx_buttons_armbian/releases"><strong>Download a Release »</strong></a>
     <br />
    <a href="https://github.com/dubpixel/dpx_buttons_armbian/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/dubpixel/dpx_buttons_armbian/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
    </p>
</div>
   <br />
<!-- TABLE OF CONTENTS -->
<details>
  <summary><h3>Table of Contents</h3></summary>
<ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#reflection">Reflection</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
</ol>
</details>
<!-- ABOUT THE PROJECT -->
<details>
<summary><h3>About The Project</h3></summary>

This project mirrors the architecture of <a href="https://github.com/elliotmatson/companion-satellite-armbian">companion-satellite-armbian</a>
but targets <strong>Bitfocus Buttons USB Relay (headless)</strong> instead of Companion Satellite — making it work on ARM single-board computers that aren't Raspberry Pis.

The build pipeline is fully automated via GitHub Actions:
<ol>
  <li>The Armbian build framework compiles a minimal Ubuntu Noble (24.04) base image for the target board.</li>
  <li>The Bitfocus Buttons USB Relay <code>.tar.gz</code> package is pulled from this repo's <code>buttons-deb-mirror</code> release (maintained manually — no Bitfocus account or secrets needed in CI).</li>
  <li><a href="https://www.packer.io/">HashiCorp Packer</a> (with the <code>arm-image</code> plugin) chroots into the image and installs the <code>.deb</code>, enables the systemd service, sets the hostname to <code>buttons-usb-relay</code>, and removes the first-login prompt.</li>
  <li>The image is zeroed, gzip-compressed, and published as a GitHub Release.</li>
</ol>

A daily scheduled workflow checks whether the mirror release has a version that hasn't been built yet, and automatically triggers a full matrix build if so.

</br>

*author(s): // www.dubpixel.tv  - i@dubpixel.tv*
</br>
</details>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

* [Armbian Build Framework](https://github.com/armbian/build) — base Linux image for ARM SBCs
* [HashiCorp Packer](https://www.packer.io/) + [arm-image plugin](https://github.com/solo-io/packer-plugin-arm-image) — chroot image customization
* [GitHub Actions](https://github.com/features/actions) — CI/CD build, scheduling, and release publishing
* [Bitfocus Buttons USB Relay (headless)](https://bitfocus.io/buttons) — the software being installed
<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- GETTING STARTED -->

## Getting Started

### Supported Boards

| Board | Armbian ID | Notes |
|---|---|---|
| Orange Pi Zero | `orangepizero` | 256/512 MB RAM — light load only |
| Orange Pi Zero 2 | `orangepizero2` | 1 GB RAM — solid all-rounder |
| Orange Pi Zero 2W | `orangepizero2w` | 1 GB RAM + onboard WiFi |
| Orange Pi Zero 3 | `orangepizero3` | 1/1.5/2/4 GB RAM — recommended |

Any board in the [Armbian supported hardware list](https://www.armbian.com/download/) can be added by editing the matrix in [.github/workflows/release-action.yaml](.github/workflows/release-action.yaml).

---

### Step 1 — Get the image

Go to the [**Releases**](https://github.com/dubpixel/dpx_buttons_armbian/releases) page and download the `.img.gz` for your board, e.g.:

```
orangepizero3-buttons-usb-relay-0.1.0-beta.4.img.gz
```

The file is a gzip-compressed raw disk image — no extraction needed before flashing.

---

### Step 2 — Flash to SD card

#### Option A: Balena Etcher (easiest, any OS)

1. Download [Balena Etcher](https://etcher.balena.io/)
2. Click **Flash from file** → select the `.img.gz` (Etcher handles the decompression)
3. Select your SD card
4. Click **Flash**

#### Option B: command line (macOS / Linux)

```bash
# Find your SD card device first
diskutil list          # macOS
lsblk                  # Linux

# macOS — unmount first, then write
diskutil unmountDisk /dev/diskN
gunzip -c orangepizero3-buttons-usb-relay-0.1.0-beta.4.img.gz \
  | sudo dd of=/dev/rdiskN bs=4m status=progress
diskutil eject /dev/diskN

# Linux
gunzip -c orangepizero3-buttons-usb-relay-0.1.0-beta.4.img.gz \
  | sudo dd of=/dev/sdX bs=4M status=progress conv=fsync
```

> ⚠️ Double-check your device path. Writing to the wrong disk will destroy data.

---

### Step 3 — First boot

1. Insert the SD card into the SBC
2. Connect your Stream Deck via USB
3. Connect ethernet (or configure WiFi after first boot)
4. Power on
5. Wait ~30 seconds for the OS to boot
6. Open **Bitfocus Buttons** on your computer — the relay appears automatically under discovered devices (mDNS, port `3040`)

The hostname is `buttons-usb-relay.local`. SSH is disabled by default (it's a headless appliance). See [Usage](#usage) if you need it.

---

### Maintaining the mirror (keeping builds up to date)

When Bitfocus releases a new version of the USB Relay software:

1. Download the ARM64 `.tar.gz` from [user.bitfocus.io/download](https://user.bitfocus.io/download)
   - Look for: `bitfocus-buttons-usb-relay-headless_X.Y.Z_arm64.tar.gz`

2. Run the upload helper (requires [GitHub CLI](https://cli.github.com/) — `brew install gh`):

   ```bash
   ./scripts/upload-mirror.sh ~/Downloads/bitfocus-buttons-usb-relay-headless_X.Y.Z_arm64.tar.gz
   ```

   This uploads the file to the `buttons-deb-mirror` release in this repo.

3. The daily scheduled build will detect the new version within 24 hours and publish a full release automatically. Or trigger it immediately:

   ```bash
   gh workflow run release-action.yaml --repo dubpixel/dpx_buttons_armbian
   ```

---

### Setting up the build pipeline (fork this repo)

1. Fork this repository on GitHub
2. Run the upload helper once to seed the mirror release with the current package:
   ```bash
   ./scripts/upload-mirror.sh ~/Downloads/bitfocus-buttons-usb-relay-headless_0.1.0-beta.4_arm64.tar.gz
   ```
3. Trigger a build manually to verify everything works:
   - **Actions → Release — Buttons USB Relay Images → Run workflow → Force: true**
4. Builds run automatically on schedule after that — just upload new packages as they drop

> No GitHub Secrets required. The pipeline only uses the built-in `GITHUB_TOKEN`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

### SSH into the device

SSH is disabled in the image by default. To re-enable it, connect a monitor + keyboard for the first boot, or temporarily enable it from another machine if you have local network access:

```bash
# From the SBC's console or a serial connection:
sudo systemctl enable --now ssh
```

Default credentials (Armbian minimal):
- **User:** `root`
- **Password:** `1234` (you will be prompted to change it on first console login)

After enabling SSH:
```bash
ssh root@buttons-usb-relay.local
# or use the IP address if mDNS isn't resolving
```

---

### Service management

```bash
# Check status
systemctl status bitfocus-buttons-usb-relay

# Live logs
journalctl -u bitfocus-buttons-usb-relay -f

# Restart
sudo systemctl restart bitfocus-buttons-usb-relay

# Stop / disable autostart
sudo systemctl stop bitfocus-buttons-usb-relay
sudo systemctl disable bitfocus-buttons-usb-relay
```

---

### Configure client mode

By default the relay runs in **server mode**: it listens on port `3040` and announces itself via mDNS so Buttons discovers it automatically. No config needed.

If mDNS doesn't work on your network (some managed switches block it), switch to **client mode** so the relay connects outbound to your Buttons server:

```bash
# SSH into the SBC, then:
sudo nano /etc/default/bitfocus-buttons-usb-relay

# Add or edit this line:
EXTRA_ARGS="-buttonsAddress 192.168.1.10:3000"

# Save and restart:
sudo systemctl restart bitfocus-buttons-usb-relay
```

---

### Network discovery

The device announces itself as `buttons-usb-relay.local` via mDNS (Avahi). If your Buttons app doesn't auto-discover it:

```bash
# From another machine on the same network:
avahi-browse -t _buttons._tcp     # Linux
dns-sd -B _buttons._tcp local     # macOS

# Or just ping to confirm it's up:
ping buttons-usb-relay.local
```
<!-- REFLECTION -->
## Reflection

* what did we learn?
  - _x_
* what do we like/hate?
  - _y_
* what would/could we do differently?
  - _z_

<!-- ROADMAP -->

- [x] Core Armbian + Packer two-stage build pipeline
- [x] Self-hosted package mirror via GitHub Releases (no Bitfocus secrets in CI)
- [x] Matrix builds for Orange Pi Zero family
- [x] Daily automated version check + GitHub Release publishing
- [x] `upload-mirror.sh` helper for one-command package updates
- [ ] Additional board support (Banana Pi M2 Zero, NanoPi R4S, Orange Pi 5)
- [ ] SHA256 checksums attached to each release
- [ ] WiFi pre-configuration support in image (via Armbian `wpa_supplicant` overlay)

See the [open issues](https://github.com/dubpixel/dpx_buttons_armbian/issues) for a full list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

_Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**._

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Top contributors:
<a href="https://github.com/dubpixel/dpx_buttons_armbian/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=dubpixel/dpx_buttons_armbian" alt="contrib.rocks image" />
</a>

<!-- LICENSE -->
## License
Distributed under the [LICENSE_TYPE] License. See `LICENSE.txt` for more information.
<!-- CONTACT -->
## Contact

  ### Joshua Fleitell - i@dubpixel.tv

  Project Link: [https://github.com/dubpixel/dpx_buttons_armbian](https://github.com/dubpixel/dpx_buttons_armbian)

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [elliotmatson/companion-satellite-armbian](https://github.com/elliotmatson/companion-satellite-armbian) — architecture and workflow pattern this project is based on
* [Bitfocus](https://bitfocus.io/) — creators of Buttons and Companion
* [Armbian](https://www.armbian.com/) — Linux for ARM SBCs

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/dubpixel/dpx_buttons_armbian.svg?style=flat-square
[contributors-url]: https://github.com/dubpixel/dpx_buttons_armbian/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/gdubpixel/dpx_buttons_armbian.svg?style=flat-square
[forks-url]: https://github.com/dubpixel/dpx_buttons_armbian/network/members
[stars-shield]: https://img.shields.io/github/stars/dubpixel/dpx_buttons_armbian.svg?style=flat-square
[stars-url]: https://github.com/dubpixel/dpx_buttons_armbian/stargazers
[issues-shield]: https://img.shields.io/github/issues/dubpixel/dpx_buttons_armbian.svg?style=flat-square
[issues-url]: https://github.com/dubpixel/dpx_buttons_armbian/issues
[license-shield]: https://img.shields.io/github/license/dubpixel/dpx_buttons_armbian.svg?style=flat-square
[license-url]: https://github.com/dubpixel/dpx_buttons_armbian/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/jfleitell
[product-front]: images/front.png
[product-rear]: images/rear.png
[product-front-rendering]: images/front_render.png
[product-rear-rendering]: images/rear_render.png
[product-pcbFront]: images/pcb_front.png
[product-pcbRear]: images/pcb_rear.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[KiCad.org]: https://img.shields.io/badge/KiCad-v8.0.6-blue
[KiCad-url]: https://kicad.org 
[Fusion-360]: https://img.shields.io/badge/Fusion360-v4.2.0-green
[Autodesk-url]: https://autodesk.com 
[FastLed.io]: https://img.shields.io/badge/FastLED-v3.9.9-red
[FastLed-url]: https://fastled.io 
