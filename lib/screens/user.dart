import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/textfield.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/disk.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/user.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Set up user account and password",
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  FlueTextField(
                    hint: "user",
                  ),
                  FlueTextField(
                    hint: "password",
                    password: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  FlueTextField(
                    hint: "email",
                  ),
                  FlueTextField(
                    hint: "confirm password",
                    password: true,
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
                      builder: (context) => const DiskContent(),
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
