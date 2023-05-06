import 'dart:io';
import "package:yaml/yaml.dart";
import 'package:ainst/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

fillConfigWithVaraibles() async {
  var prefs = await SharedPreferences.getInstance();
  var keys = prefs.getKeys();

  var homedir = await getHomeDir();
  var ainstfile = File("$homedir/.ainst.yml");
  var aisntstring = await ainstfile.readAsString();

  for (var key in keys) {
    var elem = prefs.getString(key);
    if (elem.runtimeType == bool) {
      continue;
    }
    if (elem != null) {
      aisntstring = aisntstring.replaceAll("<AINST=$elem>", elem);
    }
  }
  await ainstfile.writeAsString(aisntstring);
}

Future<String> installSystem() async {
  var homedir = await getHomeDir();
  var ainstcfg = await File("$homedir/.ainst.yml").readAsString();
  YamlMap mapData = loadYaml(ainstcfg);

  var scripts = mapData["install-scripts"] as YamlList;
  for (var call in scripts) {
    var rez = await syscall("$call");
    if (rez.error) {
      return "Unable to execute call: $call \n ${rez.stdout}${rez.stderr}";
    }
  }
  return "ok";
}

Future<String> getHomeDir() async {
  var rez = await syscall("echo \$USER");
  var homedir = "/${rez.stdout.trim()}";
  if (rez.stdout.trim() != "root") {
    homedir = "/home$homedir";
  }
  return homedir;
}
