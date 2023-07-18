import 'dart:async';

import 'package:ainst/screens/language.dart';
import 'package:ainst/utils/connect.dart';
import 'package:ainst/utils/syscall.dart';
import 'package:flutter/material.dart';
import 'package:ainst/components/buttons.dart';
import 'package:ainst/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeContent extends StatefulWidget {
  const WelcomeContent({super.key});

  @override
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  Timer timer =
      Timer.periodic(const Duration(milliseconds: 324), (timer) async {
    var prefs = await SharedPreferences.getInstance();
    if (await netcheck()) {
      prefs.setBool("connected", true);
    }
  });

  cleanPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    cleanPrefs();
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
              "assets/ainst.png",
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
                "Web development linux distrtibution. Establish network connection to proceed installation...",
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
                FmnxButton(
                  text: "Test the system",
                  onPressed: () {
                    windowManager.destroy();
                  },
                ),
                const SizedBox(width: 42),
                FmnxButton(
                  text: "Install",
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    if (prefs.getBool("connected") == true) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LanguageContent(),
                        ),
                      );
                      timer.cancel();
                      return;
                    }
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
                    timer.cancel();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
