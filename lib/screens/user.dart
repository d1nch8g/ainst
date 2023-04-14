import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/notification.dart';
import 'package:installer/components/textfield.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/disk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserContent extends StatelessWidget {
  UserContent({super.key});

  final userController = TextEditingController();
  final passController = TextEditingController();
  final confpassController = TextEditingController();

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
            const SizedBox(height: 32),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlueTextField(
                    hint: "user",
                    controller: userController,
                  ),
                  const SizedBox(width: 32),
                  FlueTextField(
                    hint: "password",
                    password: true,
                    controller: passController,
                  ),
                  const SizedBox(width: 32),
                  FlueTextField(
                    hint: "confirm password",
                    password: true,
                    controller: confpassController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
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
                UserCheckButton(
                  userController: userController,
                  passController: passController,
                  confpassController: confpassController,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserCheckButton extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final TextEditingController confpassController;
  const UserCheckButton({
    super.key,
    required this.userController,
    required this.passController,
    required this.confpassController,
  });

  setParams({
    required String user,
    required String pass,
    required String confpass,
  }) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user);
    prefs.setString("pass", pass);
    prefs.setString("confpass", confpass);
  }

  @override
  Widget build(BuildContext context) {
    return FleuTextButton(
      text: "Next",
      onPressed: () {
        if (passController.text != confpassController.text) {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Password does not match",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        if (userController.text.length < 3) {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Username is too short",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DiskContent(),
        ));
        setParams(
          user: userController.text,
          pass: passController.text,
          confpass: confpassController.text,
        );
      },
    );
  }
}
