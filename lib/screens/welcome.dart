import 'dart:io';

import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/utils/senderr.dart';
import 'package:installer/utils/syscall.dart';
import 'package:window_manager/window_manager.dart';

class WelcomeContent extends StatefulWidget {
  const WelcomeContent({super.key});

  @override
  State<WelcomeContent> createState() => _WelcomeContentState();
}

class _WelcomeContentState extends State<WelcomeContent> {
  List<String> keyboardLanguages = [];
  List<String> systemLanguages = [];
  List<String> timezoneList = [];

  setParams() async {
    var kmaps = await syscall("localectl --no-pager list-keymaps");
    if (kmaps.error) {
      sendErr("stderr: ${kmaps.stderr} / ${kmaps.stdout}");
      return;
    }
    var tdctl = await syscall("timedatectl --no-pager list-timezones");
    if (tdctl.error) {
      sendErr("stderr: ${kmaps.stderr} / ${kmaps.stdout}");
      return;
    }
    var str = await File("/etc/locale.gen").readAsString();
    var splitted = str.split("\n");
    List<String> langs = [];
    for (var element in splitted) {
      element = element.replaceAll("#", '').trim();
      if (element != '') {
        langs.add(element.split(" ")[0]);
      }
      if (element.startsWith("and is incl")) {
        langs = [];
        continue;
      }
    }
    setState(() {
      keyboardLanguages = kmaps.stdout.split("\n");
      systemLanguages = langs;
      timezoneList = tdctl.stdout.split("\n");
    });
  }

  @override
  void initState() {
    setParams();
    super.initState();
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
              "assets/fleuos.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Welcome to FleuOS",
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
                "You can test the system on this live ISO image, or run installation process.",
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
                FleuTextButton(
                  text: "Test system",
                  onPressed: () {
                    windowManager.destroy();
                  },
                ),
                const SizedBox(width: 42),
                FleuTextButton(
                  text: "Install",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LanguageContent(
                          keyboardLanguages: keyboardLanguages,
                          systemLanguages: systemLanguages,
                          timezoneList: timezoneList,
                        ),
                      ),
                    );
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
