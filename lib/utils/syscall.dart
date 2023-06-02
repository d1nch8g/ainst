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
  var rez = await Process.run("bash", ["-c", input]);
  return CallResult(
    stdout: "${rez.stdout}",
    stderr: "${rez.stderr}",
    error: rez.exitCode != 0,
  );
}
