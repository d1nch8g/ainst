import 'dart:io';

import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/dropdown.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/user.dart';
import 'package:installer/utils/senderr.dart';
import 'package:installer/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageContent extends StatefulWidget {
  const LanguageContent({super.key});

  @override
  State<LanguageContent> createState() => _LanguageContentState();
}

class _LanguageContentState extends State<LanguageContent> {
  List<String> keyboardLanguages = ["Russian"];
  List<String> systemLanguages = ["English"];
  List<String> timezoneList = ["Moscow/Europe"];

  setKeyboardLanguages() async {
    var out = await syscall("localectl --no-pager list-keymaps");
    if (out.error) {
      sendErr("Stderr: ${out.stderr}, stdout: ${out.stdout}");
      return [];
    }
    setState(() {
      keyboardLanguages = out.stdout.split("\n");
    });
  }

  setTimezoneList() async {
    var out = await syscall("timedatectl --no-pager list-timezones");
    if (out.error) {
      sendErr("Stderr: ${out.stderr}, stdout: ${out.stdout}");
      return [];
    }
    setState(() {
      timezoneList = out.stdout.split("\n");
    });
  }

  setSystemLanguages() async {
    var str = await File("/etc/locale.gen").readAsString();
    var splitted = str.split("\n");
    List<String> rez = [];
    for (var element in splitted) {
      element = element.replaceAll("#", '').trim();
      if (element != '') {
        rez.add(element.split(" ")[0]);
      }
      if (element.startsWith("and is incl")) {
        rez = [];
        continue;
      }
    }
    setState(() {
      systemLanguages = rez;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setKeyboardLanguages();
      setTimezoneList();
      setSystemLanguages();
    });
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
              "assets/language.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Choose system and keyboard languages",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FleuDropdown(
                    items: systemLanguages,
                    label: 'System language',
                    onChanged: (v) async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("syslang", v);
                    },
                  ),
                  FleuDropdown(
                    items: keyboardLanguages,
                    label: 'Keyboard layout',
                    onChanged: (v) async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("keyboardlang", v);
                    },
                  ),
                  FleuDropdown(
                    items: timezoneList,
                    label: 'Timezone',
                    onChanged: (v) async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("keyboardlang", v);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 54),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FleuTextButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 42),
                FleuTextButton(
                  text: "Next",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserContent(),
                    ));
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
