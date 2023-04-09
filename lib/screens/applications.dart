import 'package:flutter/material.dart';
import 'package:installer/components/dropdown.dart';
import 'package:installer/constants.dart';

class ApplicationsContent extends StatelessWidget {
  const ApplicationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: const Text(
            "Applications",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Divider(),
        Application(appName: "docker"),
      ],
    );
  }
}

class ApplicationGroup extends StatelessWidget {
  const ApplicationGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Application extends StatefulWidget {
  final String appName;
  const Application({super.key, required this.appName});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.appName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              Image.asset(
                "assets/${widget.appName}.png",
                width: 65,
                height: 65,
              ),
              const SizedBox(height: 12),
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
