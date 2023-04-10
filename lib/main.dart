import 'package:flutter/material.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/software.dart';
import 'package:installer/screens/disk.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/screens/user.dart';
import 'package:installer/screens/welcome.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setFullScreen(true);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FleuOS installtion',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      themeMode: ThemeMode.dark,
      home: const WelcomeContent(),
    );
  }
}
