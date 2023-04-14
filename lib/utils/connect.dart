import 'package:installer/utils/syscall.dart';

// Returns true if it's ok
Future<bool> check() async {
  var rez = await syscall("ping -c 2 yandex.ru");
  return !rez.error;
}

Future<List<String>> scan() async {
  var rez = await syscall("nmcli -c no -m multiline device wifi list  ");
  List<String> results = [];
  if (rez.error) {
    return [];
  }
  for (var line in rez.stdout.split("\n")) {
    if (line.startsWith("SSID:")) {
      var trimmed = line.replaceAll(RegExp(" +"), " ");
      var name = trimmed.replaceAll("SSID: ", "");
      if (name != "--") {
        results.add(name);
      }
    }
  }
  return results;
}

// Returns true if it's ok
Future<bool> connect(String net, String pass) async {
  var rez = await syscall("nmcli device wifi connect $net password $pass");
  return !rez.error;
}
