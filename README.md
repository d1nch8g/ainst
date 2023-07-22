<p align="center">
<img style="align: center; padding-left: 10px; padding-right: 10px; padding-bottom: 10px;" width="238px" height="238px" src="https://fmnx.su/core/ainst/raw/branch/main/assets/ainst.png" />
</p>

<h2 align="center">System installation utility</h2>

![Generic badge](https://img.shields.io/badge/status-alpha-red.svg)
[![Generic badge](https://img.shields.io/badge/flaticon-icons-03fca1.svg)](https://www.flaticon.com)
[![Generic badge](https://img.shields.io/badge/license-gpl-orange.svg)](https://fmnx.su/core/ainst/src/branch/main/LICENSE)
[![Generic badge](https://img.shields.io/badge/fmnx-repo-006db0.svg)](https://fmnx.su/core/ainst)
[![Generic badge](https://img.shields.io/badge/github-repo-white.svg)](https://github.com/fmnx-su/ainst)
[![Generic badge](https://img.shields.io/badge/codeberg-repo-45a3fb.svg)](https://codeberg.org/fmnx/ainst)
[![Generic badge](https://img.shields.io/badge/arch-package-00bcd4.svg)](https://fmnx.su/core/-/packages/arch/ainst)

> **Warning!** Project is in alpha stage, API's are very likely to be changed.

Ainst is a system installation UI. You can use it to execute installation scripts with paramters provided by user as inputs in application text fields. To test ainst you can install it with [pack](https://fmnx.su/core/pack), place `~/ainst.yml` in your home directory and run installer. It swap variables in scripts and sequentially execute `install-script` list provided in configuration line by line.

Is is much easier to adjust installation application for your distribution needs if you don't have to recompile it each time you build an ISO, ainst is just a UI which can execute any installation script.

Currently, only installation scripts can be configured in runtime, but we are planning to extend configuration to provide ability to add additional views, text input forms, change fonts, colors, images, etc...

You can find example of `ainst.yml` in [fmnx iso repo](https://fmnx.su/core/iso).

- UI for hardware parameters:

![](examples/disks.png)

- UI for language picker:

![](examples/langs.png)

### Configurations:

The amount of configurations is limited at the moment, but we are working on that 🔨🔨🔨. At the moment you can adjust packages required for installation and installation scripts in `~/ainst.yml` file (typically /root/ainst.yml, if you have not created any users).

Default configuration:

```yml
install-scripts:
  - archinstall --silent --disk_layouts /usr/disk.json --config /usr/config.json --creds /usr/creds.json
  - cp /etc/os-release /mnt/archinstall/etc/os-release
  - cp /etc/pacman.conf /mnt/archinstall/etc/pacman.conf
  - ...
```
