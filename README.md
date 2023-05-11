<p align="center">
<img style="align: center; padding-left: 10px; padding-right: 10px; padding-bottom: 10px;" width="238px" height="238px" src="https://fmnx.io/dancheg97/Pictures/raw/branch/main/ainst.png" />
</p>

<h2 align="center">System installation utility</h2>

[![Generic badge](https://img.shields.io/badge/LICENSE-GPL-orange.svg)](https://fmnx.io/core/ainst/src/branch/main/LICENSE)
[![Generic badge](https://img.shields.io/badge/FMNX-REPO-006db0.svg)](https://fmnx.io/core/ainst)
[![Generic badge](https://img.shields.io/badge/GITHUB-REPO-white.svg)](https://github.com/fmnx-io/ainst)
[![Generic badge](https://img.shields.io/badge/CODEBERG-REPO-45a3fb.svg)](https://codeberg.org/fmnx/ainst)
[![Build Status](https://ci.fmnx.io/api/badges/core/ainst/status.svg)](https://ci.fmnx.io/core/ainst)

UI wrapper over archinstall utility styled to suite gnome applications. Installer is in alpha stage and providing only base functionality of archinstall, but can be easily customized and completed with all required functionality. Flutter app is making system calls to archinstall and serves only as graphical representation to provide user-friendly experience for installation process.

You can find example of `.ainst.yml` in [fmnx iso repo](https://fmnx.io/core/iso)

- Hardware parameters:

![](examples/disks.png)

- Language choice example:

![](examples/langs.png)

### ⚙️ Configurations:

The amount of configurations is limited at the moment, but we are working on that 🔨🔨🔨. At the moment you can adjust packages required for installation and installation scripts in `~/.ainst.yml` file (typically /root/.ainst.yml, if you have not created any users).

Default configuration:

```yml
additional-packages:
  - bluez
  - bluez-utils
  - dconf
  - ...
install-scripts:
  - archinstall --silent --disk_layouts /usr/disk.json --config /usr/config.json --creds /usr/creds.json
  - cp /etc/os-release /mnt/archinstall/etc/os-release
  - cp /etc/pacman.conf /mnt/archinstall/etc/pacman.conf
  - ...
```

### 📦 Install package with [pack](https://fmnx.io/core/pack):

```
pack i fmnx.io/core/ainst
```

<!--
Make evrything configurable with a yaml as a builder:
 - spinners
 - what to be shown and where
 - which input params will do what
 - which scripts will push wut??
xprop WM_CLASS
-->
