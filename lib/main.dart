import 'package:flutter/material.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/screens/welcome.dart';
import 'package:introduction_slider/source/source.dart';

void main() async {
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
      home: const Scaffold(
        body: InstallationScreen(),
      ),
    );
  }
}

class InstallationScreen extends StatelessWidget {
  const InstallationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: const [
        IntroductionSliderItem(
          logo: WelcomeContent(),
          backgroundColor: backgroundColor,
        ),
        IntroductionSliderItem(
          logo: LanguageContent(),
          // title: Text("Title 2"),
          backgroundColor: backgroundColor,
        ),
        IntroductionSliderItem(
          logo: FlutterLogo(),
          // title: Text("Title 2"),
          backgroundColor: backgroundColor,
        ),
      ],
      done: const Done(
        child: Icon(Icons.done),
        home: Text("yo"),
      ),
      next: const Next(
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
