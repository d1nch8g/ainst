import 'package:flutter/material.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            "Lets set up system parameters and run installation",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
