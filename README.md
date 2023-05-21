<p align="center">
<img style="align: center; padding-left: 10px; padding-right: 10px; padding-bottom: 10px;" width="238px" height="238px" src="https://fmnx.su/dancheg97/Pictures/raw/branch/main/ainst.png" />
</p>

<h2 align="center">System installation utility</h2>

![Generic badge](https://img.shields.io/badge/status-alpha-red.svg)
[![Generic badge](https://img.shields.io/badge/flaticon-icons-03fca1.svg)](https://www.flaticon.com)
[![Generic badge](https://img.shields.io/badge/license-gpl-orange.svg)](https://fmnx.su/core/ainst/src/branch/main/LICENSE)
[![Generic badge](https://img.shields.io/badge/fmnx-repo-006db0.svg)](https://fmnx.su/core/ainst)
[![Generic badge](https://img.shields.io/badge/github-repo-white.svg)](https://github.com/fmnx-io/ainst)
[![Generic badge](https://img.shields.io/badge/codeberg-repo-45a3fb.svg)](https://codeberg.org/fmnx/ainst)
[![Build Status](https://ci.fmnx.su/api/badges/core/ainst/status.svg)](https://ci.fmnx.su/core/ainst)

> **Warning!** Project is in alpha stage, API's are very likely to be changed.

UI wrapper over archinstall utility styled to suite gnome applications. Installer is in alpha stage and providing only base functionality of archinstall, but can be easily customized and completed with all required functionality. Flutter app is making system calls to archinstall and serves only as graphical representation to provide user-friendly experience for installation process.

You can find example of `.ainst.yml` in [fmnx iso repo](https://fmnx.su/core/iso)

- Hardware parameters:

![](examples/disks.png)

- Language choice example:

![](examples/langs.png)

### ⚙️ Configurations:

The amount of configurations is limited at the moment, but we are working on that 🔨🔨🔨. At the moment you can adjust packages required for installation and installation scripts in `~/.ainst.yml` file (typically /root/.ainst.yml, if you have not created any users).

Default configuration:

```yml
install-scripts:
  - archinstall --silent --disk_layouts /usr/disk.json --config /usr/config.json --creds /usr/creds.json
  - cp /etc/os-release /mnt/archinstall/etc/os-release
  - cp /etc/pacman.conf /mnt/archinstall/etc/pacman.conf
  - ...
```

### 📦 Install package with [pack](https://fmnx.su/core/pack):

```
pack i fmnx.su/core/ainst
```
