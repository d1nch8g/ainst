import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/notification.dart';
import 'package:installer/components/textfield.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/hardware.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserContent extends StatelessWidget {
  UserContent({super.key});

  final userController = TextEditingController();
  final emailController = TextEditingController();
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
                "Create user",
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
                  TextForm(
                    hint: "Name",
                    controller: userController,
                  ),
                  const SizedBox(width: 32),
                  TextForm(
                    hint: "Email",
                    controller: emailController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextForm(
                    hint: "Password",
                    password: true,
                    controller: passController,
                  ),
                  const SizedBox(width: 32),
                  TextForm(
                    hint: "Password check",
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
                FmnxTextButton(
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
                  emailController: emailController,
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
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController confpassController;
  const UserCheckButton({
    super.key,
    required this.userController,
    required this.emailController,
    required this.passController,
    required this.confpassController,
  });

  setParams(String user, String email, String pass) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user);
    prefs.setString("email", email);
    prefs.setString("pass", pass);
  }

  @override
  Widget build(BuildContext context) {
    return FmnxTextButton(
      text: "Next",
      onPressed: () {
        if (passController.text != confpassController.text) {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Passwords does not match",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        if (!emailController.text.contains("@") ||
            !emailController.text.contains(".")) {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Email is incorrect",
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
                message: "User name is too short",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HardwareContent(),
        ));
        setParams(
          userController.text,
          emailController.text,
          passController.text,
        );
      },
    );
  }
}
