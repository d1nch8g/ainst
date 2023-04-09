import 'package:flutter/material.dart';
import 'package:installer/components/textfield.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
