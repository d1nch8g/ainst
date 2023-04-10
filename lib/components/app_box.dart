import 'package:flutter/material.dart';
import 'package:installer/constants.dart';

class AppBox extends StatefulWidget {
  final String appName;
  const AppBox({super.key, required this.appName});

  @override
  State<AppBox> createState() => _AppBoxState();
}

class _AppBoxState extends State<AppBox> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(21, 6, 21, 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.appName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 9),
              Image.asset(
                "assets/${widget.appName}.png",
                width: 54,
                height: 54,
              ),
              const SizedBox(height: 9),
              Checkbox(
                value: checked,
                focusColor: secondaryColor,
                activeColor: primaryColor,
                checkColor: backgroundColor,
                fillColor: const MaterialStatePropertyAll(Colors.white),
                onChanged: (v) {
                  setState(() {
                    checked = v!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
