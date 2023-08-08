import 'dart:io';

class CallResult {
  final String stdout;
  final String stderr;
  final bool error;
  CallResult({
    required this.stdout,
    required this.stderr,
    required this.error,
  });
}

Future<CallResult> syscall(String input) async {
  var rez = await Process.start("bash", ["-c", input]);
  var out = "";
  var err = "";

  await rez.stdout.forEach((b) {
    var str = String.fromCharCodes(b);
    stdout.write(str);
    out += str;
  });

  await rez.stderr.forEach((b) {
    var str = String.fromCharCodes(b);
    stderr.write(str);
    err += str;
  });

  return CallResult(
    stdout: out,
    stderr: err,
    error: await rez.exitCode != 0,
  );
}
