import 'dart:io';

import 'package:installer/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

const dataDir = "/usr";
const userDir = "/root";
// const dataDir = "/home/dancheg97/fmnx-install";
// const userDir = "/home/dancheg97/fmnx-install";

Future writeConfigurations() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user")!;
  var pass = prefs.getString("pass")!;
  var email = prefs.getString("email")!;
  var disk = prefs.getString("disk")!;
  var syslang = prefs.getString("syslang");
  var kblayout = prefs.getString("kblayout");
  var timezone = prefs.getString("timezone");

  var pkgsFile = File("$dataDir/additional_packages");
  var rawPkgs = await pkgsFile.readAsString();
  var packages = rawPkgs.split("\n");
  var jsonPkgs = '"${packages.join('","')}"';

  var credsFile = File("$dataDir/creds.json");
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

  var diskFile = File("$dataDir/disk.json");
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

  var configFile = File("$dataDir/config.json");
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
    $jsonPkgs
  ],
  "script": "guided",
  "silent": false,
  "swap": false,
  "sys-encoding": "UTF-8",
  "version": "2.5.5"
}''');

  var gitfile = File("$userDir/.gitconfig");
  configFile = await gitfile.writeAsString('''[credential]
	helper = store
[user]
	name = $user
	email = $email
[safe]
	directory = /opt/flutter
''');
}

Future<String> installSystem() async {
  var prefs = await SharedPreferences.getInstance();
  var user = prefs.getString("user")!;

  var installFile = File("$dataDir/install.sh");
  var rawInstall = await installFile.readAsString();
  var rawInstallWithUser = rawInstall.replaceAll("<USER>", user);
  var callList = rawInstallWithUser.split("\n");

  for (var call in callList) {
    var rez = await syscall(call);
    if (rez.error) {
      return "Unable to execute call: $call \n ${rez.stdout}${rez.stderr}";
    }
  }
  return "ok";
}
