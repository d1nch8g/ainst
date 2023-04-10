import 'package:flutter/material.dart';
import 'package:installer/components/app_box.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/installation.dart';

class SoftwareContent extends StatelessWidget {
  const SoftwareContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Software",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              color: Colors.white,
              indent: MediaQuery.of(context).size.width * 0.25,
              endIndent: MediaQuery.of(context).size.width * 0.25,
              thickness: 0.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Expanded(
                child: ListView(
                  children: [
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
                        AppBox(appName: "onlyoffice"),
                        AppBox(appName: "wps-office"),
                        AppBox(appName: "open-office"),
                      ],
                    ),
                    const Text(
                      "Internet",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "chromium"),
                        AppBox(appName: "yandex"),
                        AppBox(appName: "vivaldi"),
                        AppBox(appName: "firefox"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "opera"),
                        AppBox(appName: "gnome-web"),
                        AppBox(appName: "falkon"),
                        AppBox(appName: "tor"),
                      ],
                    ),
                    const Text(
                      "Communication",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "telegram"),
                        AppBox(appName: "mattermost"),
                        AppBox(appName: "discord"),
                        AppBox(appName: "slack"),
                        AppBox(appName: "element"),
                        AppBox(appName: "signal"),
                      ],
                    ),
                    const Text(
                      "Graphics and editing",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "blender"),
                        AppBox(appName: "godot"),
                        AppBox(appName: "krita"),
                        AppBox(appName: "lunacy"),
                        AppBox(appName: "audacity"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "kdenlive"),
                        AppBox(appName: "openshot"),
                        AppBox(appName: "gaphor"),
                        AppBox(appName: "gimp"),
                        AppBox(appName: "blockbench"),
                      ],
                    ),
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
                        AppBox(appName: "vscode"),
                        AppBox(appName: "nvim"),
                        AppBox(appName: "docker"),
                        AppBox(appName: "dart"),
                        AppBox(appName: "protoc"),
                        AppBox(appName: "rust"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        AppBox(appName: "golang"),
                        AppBox(appName: "nodejs"),
                        AppBox(appName: "flutter"),
                        AppBox(appName: "vlang"),
                        AppBox(appName: "lua"),
                        AppBox(appName: "elixir"),
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
            const SizedBox(height: 24),
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
                FleuTextButton(
                  text: "Next",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InstallationContent(),
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
