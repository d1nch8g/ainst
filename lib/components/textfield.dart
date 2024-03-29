import 'package:flutter/material.dart';
import 'package:ainst/constants.dart';

class TextForm extends StatelessWidget {
  final String hint;
  final bool password;
  final TextEditingController controller;
  const TextForm({
    super.key,
    required this.hint,
    required this.controller,
    this.password = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: TextFormField(
        controller: controller,
        obscureText: password,
        cursorColor: primaryColorLight,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: const TextStyle(color: Colors.white),
          hintText: hint,
          fillColor: secondaryColor,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
