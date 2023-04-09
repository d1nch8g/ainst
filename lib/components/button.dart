import 'package:flutter/material.dart';
import '../../../../constants.dart';

class FlueButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final IconData icon;
  const FlueButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        backgroundColor: primaryColor,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
