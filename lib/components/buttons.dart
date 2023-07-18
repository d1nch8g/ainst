import 'package:flutter/material.dart';
import '../../../../constants.dart';

class FmnxButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const FmnxButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: const BorderSide(color: primaryColor),
        ),
        backgroundColor: secondaryColor,
        foregroundColor: primaryColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
