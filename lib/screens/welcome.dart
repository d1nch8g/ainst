import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/utils/connect.dart';
import 'package:installer/utils/syscall.dart';
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
        onPressed: () async {
          var connected = await netcheck();
          if (!connected) {
            syscall("gnome-control-center");
            return;
          }
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LanguageContent(),
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
                "System installation",
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
                "First connect to wifi, then run installation.",
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
