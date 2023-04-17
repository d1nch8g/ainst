import 'dart:io';

import 'package:installer/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future writeConfigurations() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user")!;
  var pass = prefs.getString("pass")!;
  var disk = prefs.getString("disk")!;
  var syslang = prefs.getString("syslang");
  var kblayout = prefs.getString("kblayout");
  var timezone = prefs.getString("timezone");

  var credsFile = File("/root/creds.json");
  credsFile = await credsFile.writeAsString('''{
  "!root-password": "$pass",
  "!users": [
    {
      "username": "$user",
      "!password": "$pass",
      "sudo": true
    }
  ]
}''');

  var diskFile = File("/root/disk.json");
  diskFile = await diskFile.writeAsString('''{
  "/dev/$disk": {
    "partitions": [
      {
        "boot": true,
        "encrypted": false,
        "filesystem": {
          "format": "fat32"
        },
        "mountpoint": "/boot",
        "size": "512MiB",
        "start": "1MiB",
        "type": "primary",
        "wipe": true
      },
      {
        "btrfs": {
          "subvolumes": [
            {
              "compress": false,
              "mountpoint": "/",
              "name": "@",
              "nodatacow": false
            },
            {
              "compress": false,
              "mountpoint": "/home",
              "name": "@home",
              "nodatacow": false
            },
            {
              "compress": false,
              "mountpoint": "/var/log",
              "name": "@log",
              "nodatacow": false
            },
            {
              "compress": false,
              "mountpoint": "/var/cache/pacman/pkg",
              "name": "@pkg",
              "nodatacow": false
            },
            {
              "compress": false,
              "mountpoint": "/.snapshots",
              "name": "@.snapshots",
              "nodatacow": false
            }
          ]
        },
        "encrypted": false,
        "filesystem": {
          "format": "btrfs",
          "mount_options": []
        },
        "mountpoint": null,
        "size": "100%",
        "start": "513MiB",
        "type": "primary",
        "wipe": true
      }
    ],
    "wipe": true
  }
}''');

  var configFile = File("/root/config.json");
  configFile = await configFile.writeAsString('''{
  "additional-repositories": ["multilib"],
  "audio": "pipewire",
  "config_version": "2.5.5",
  "debug": false,
  "desktop-environment": "gnome",
  "gfx_driver": "All open-source (default)",
  "harddrives": ["/dev/$disk"],
  "hostname": "fmnx-$user",
  "keyboard-layout": "$kblayout",
  "sys-language": "$syslang",
  "timezone": "$timezone",
  "bootloader": "systemd-bootctl",
  "nic": {
    "dhcp": true,
    "dns": null,
    "gateway": null,
    "iface": null,
    "ip": null,
    "type": "nm"
  },
  "no_pkg_lookups": false,
  "offline": false,
  "profile": {
    "path": "/usr/lib/python3.10/site-packages/archinstall/profiles/desktop.py"
  },
  "packages": [
    "gnome-shell",
    "gnome-session",
    "gnome-terminal",
    "gnome-control-center",
    "gnome-settings-daemon",
    "gnome-calculator",
    "gnome-calendar",
    "gnome-disk-utility",
    "gnome-keyring",
    "gnome-logs",
    "gnome-system-monitor",
    "gnome-shell-extensions",
    "gnome-tweaks",
    "gnome-characters",
    "gnome-browser-connector",
    "gnome-weather",
    "gnome-shell-extension-dash-to-dock",
    "gnome-shell-extension-gtile",
    "dconf",
    "dconf-editor",
    "chromium",
    "geary",
    "simple-scan",
    "nautilus",
    "xorg-drivers",
    "networkmanager",
    "gedit",
    "eog",
    "nano",
    "git",
    "xdg-user-dirs-gtk",
    "papirus-icon-theme",
    "ttf-droid",
    "adw-gtk-theme",
    "zsh-autosuggestions",
    "zsh-syntax-highlighting",
    "zsh-theme-powerlevel10k-bin-git",
    "deja-dup",
    "baobab",
    "drawing",
    "yay",
    "onlyoffice-bin",
    "telegram-desktop"
  ],
  "script": "guided",
  "silent": false,
  "swap": false,
  "sys-encoding": "UTF-8",
  "version": "2.5.5"
}''');
}

Future<String> installSystem() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user")!;

  var callList = [
    "archinstall --silent --disk_layouts disk.json --config config.json --creds creds.json",
    "cp /etc/os-release /mnt/archinstall/etc/os-release",
    "cp /etc/pacman.conf /mnt/archinstall/etc/pacman.conf",
    "mkdir -p /mnt/archinstall/etc/dconf/profile",
    "cp /etc/dconf/profile/user /mnt/archinstall/etc/dconf/profile/user",
    "mkdir -p /mnt/archinstall/etc/dconf/db/local.d",
    "cp /etc/dconf/db/local.d/00-settings /mnt/archinstall/etc/dconf/db/local.d/00-settings",
    "mkdir -p /mnt/archinstall/etc/dconf/profile",
    "cp /etc/dconf/profile/user /mnt/archinstall/etc/dconf/profile/user",
    "cp -R /root/* /mnt/archinstall/home/$user",
    "cp -R /root/.[^.]* /mnt/archinstall/home/$user",
    "chmod a+rwx -R /mnt/archinstall/home/$user",
    "mkdir -p /mnt/archinstall/usr/local/share/backgrounds",
    "cp /usr/local/share/backgrounds/wallpaper.jpg /mnt/archinstall/usr/local/share/backgrounds/wallpaper.jpg",
    "cp /usr/local/share/backgrounds/fmnx-linux.png /mnt/archinstall/usr/local/share/backgrounds/fmnx-linux.png",
    "arch-chroot /mnt/archinstall pacman -R --noconfirm epiphany gnome-music gnome-console",
    "arch-chroot /mnt/archinstall dconf update",
    "sed -i s|/bin/bash|/usr/bin/zsh|g /mnt/archinstall/etc/passwd",
    "sed -i s/3/0/g /mnt/archinstall/boot/loader/loader.conf",
  ];

  for (var call in callList) {
    var rez = await syscall(call);
    if (rez.error) {
      return "Unable to execute call: $call \n ${rez.stdout}${rez.stderr}";
    }
  }
  return "ok";
}
