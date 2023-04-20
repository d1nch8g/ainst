import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/screens/wifi.dart';
import 'package:installer/utils/connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeContent extends StatefulWidget {
  const WelcomeContent({super.key});

  @override
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  Widget connectWidget = const FmnxTextButton(text: "Install");

  cleanPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  checkConn() async {
    var connected = await netcheck();
    if (connected) {
      setState(() {
        connectWidget = FmnxTextButton(
          text: "Install",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LanguageContent(),
              ),
            );
          },
        );
      });
      return;
    }
    setState(() {
      connectWidget = FmnxTextButton(
        text: "Install",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WifiContent(),
            ),
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    cleanPrefs();
    checkConn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Welcome to FMNX installer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "You can test the live ISO image or run installation.",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FmnxTextButton(
                  text: "Test the system",
                  onPressed: () {
                    windowManager.destroy();
                  },
                ),
                const SizedBox(width: 42),
                connectWidget,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
