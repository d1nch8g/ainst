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
        Divider(
          color: Colors.white,
          indent: MediaQuery.of(context).size.width * 0.25,
          endIndent: MediaQuery.of(context).size.width * 0.25,
          thickness: 0.2,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Expanded(
            child: ListView(
              children: [
                const Text(
                  "Development",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Application(appName: "vscode"),
                    Application(appName: "nvim"),
                    Application(appName: "docker"),
                    Application(appName: "dart"),
                    Application(appName: "golang"),
                    Application(appName: "nodejs"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Application(appName: "protoc"),
                    Application(appName: "rust"),
                    Application(appName: "flutter"),
                    Application(appName: "vlang"),
                    Application(appName: "lua"),
                    Application(appName: "elixir"),
                  ],
                ),
                const Text(
                  "Office",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Application(appName: "onlyoffice"),
                    Application(appName: "wps-office"),
                    Application(appName: "open-office"),
                    Application(appName: "gnome-office"),
                  ],
                ),
                const Text(
                  "Graphics",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Application(appName: "blender"),
                    Application(appName: "godot"),
                    Application(appName: "krita"),
                    Application(appName: "gimp"),
                    Application(appName: "unreal"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.white,
          indent: MediaQuery.of(context).size.width * 0.25,
          endIndent: MediaQuery.of(context).size.width * 0.25,
          thickness: 0.2,
        ),
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
