import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/dropdown.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/user.dart';

class LanguageContent extends StatefulWidget {
  const LanguageContent({super.key});

  @override
  State<LanguageContent> createState() => _LanguageContentState();
}

class _LanguageContentState extends State<LanguageContent> {
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
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FleuDropdown(
                    items: const [
                      'Esperanto',
                      'English',
                      'Russian',
                    ],
                    label: 'System language',
                    onChanged: (v) {},
                  ),
                  FleuDropdown(
                    items: const [
                      'Russian',
                      'English',
                      'Esperanto',
                    ],
                    label: 'Keyboard layout',
                    onChanged: (v) {},
                  ),
                  FleuDropdown(
                    items: const [
                      'Moscow',
                      'Novosib',
                      'Vladik',
                    ],
                    label: 'Timezone',
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
