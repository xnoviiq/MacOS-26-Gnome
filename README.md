<div align="center">

# MacOS 26 for Ubuntu GNOME

A lightweight, one-command macOS 26 "Liquid Glass" setup for Ubuntu GNOME.

![Desktop Preview](screenshots/desktop.png)

[![Ubuntu](https://img.shields.io/badge/Ubuntu-26.04-E95420?style=flat-square&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![GNOME](https://img.shields.io/badge/GNOME-46%E2%80%9350-4A86CF?style=flat-square&logo=gnome&logoColor=white)](https://www.gnome.org/)
[![License](https://img.shields.io/github/license/xnoviiq/MacOS-26-Gnome?style=flat-square)](LICENSE)
[![Instagram](https://img.shields.io/badge/Instagram-%40xnoviq-E4405F?style=flat-square&logo=instagram&logoColor=white)](https://instagram.com/xnoviq)

</div>

---

## Why I built this

Most macOS GNOME guides take hours of manual tweaking, break on newer GNOME versions, or tank FPS on older laptops. I daily-drive an 8th-gen Intel i3 laptop with integrated graphics, so I bundled everything into a single automated script that stays smooth at 60fps without heavy background bloat.

## Quick Install

    git clone https://github.com/xnoviiq/MacOS-26-Gnome.git
    cd MacOS-26-Gnome
    chmod +x install.sh
    ./install.sh

> **Note:** Log out and back in after the script finishes so Wayland/GNOME reloads all shell themes and extensions cleanly.

## What's Included

- **GTK & Shell Theme:** MacTahoe + Liquid Glass widgets
- **Dock:** Dash to Dock Lite (configured with custom macOS dark app-grid icon)
- **Icons:** MacOS-Like-Dark (with `.desktop` icon overrides for AppImages and common apps)
- **Window Corners:** Rounded Window Corners Reborn (forced on maximized windows)
- **Typography & Emojis:** macOS system fonts and Tahoe color emoji support

## Screenshots

| Desktop & Dock | App Grid & Transparency |
| :---: | :---: |
| ![Desktop](screenshots/desktop.png) | ![Apps](screenshots/apps.png) |

## Tested On

- **OS:** Ubuntu 26.04 (Resolute)
- **DE:** GNOME 50 (Wayland)
- **Hardware:** Intel Core i3 (8th Gen), 12GB RAM, Intel UHD Graphics

## Roadmap

- [x] macOS 26 Tahoe (Liquid Glass) edition
- [ ] macOS Sequoia edition
- [ ] macOS Sonoma edition
- [x] Uninstaller / restore script

## Credits & Upstream Projects

This setup automates and configures existing open-source themes and extensions:
- [MacTahoe GTK Theme](https://github.com/vinceliuice/MacTahoe-gtk-theme)
- [Dash to Dock Lite](https://extensions.gnome.org/)
- [Rounded Window Corners Reborn](https://extensions.gnome.org/)

## Support & Donations

This project is completely free and open-source. I'm an independent student developer building and testing everything on an older 8th-gen i3 laptop—so if this saved you hours of ricing or brought your old laptop to life, supporting the project directly helps me keep maintaining it and building the Sequoia and Sonoma versions.

- **Star the repo:** Hit the ⭐ button at the top right so more Linux users can find it.
- **Donate / Support:** Message me directly on Instagram **[@xnoviq](https://instagram.com/xnoviq)** if you'd like to donate or support future updates.
- **Share feedback:** Open an issue or PR if you test it on another distro or GNOME version.

<div align="center">

[![Support on Instagram](https://img.shields.io/badge/Support_&_Donate-%40xnoviq-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/xnoviq)
[![Star on GitHub](https://img.shields.io/github/stars/xnoviiq/MacOS-26-Gnome?style=for-the-badge&logo=github)](https://github.com/xnoviiq/MacOS-26-Gnome)

</div>
