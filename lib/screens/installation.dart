import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
import 'package:installer/utils/install.dart';
import 'package:installer/utils/syscall.dart';

class InstallationContent extends StatefulWidget {
  const InstallationContent({super.key});

  @override
  State<InstallationContent> createState() => _InstallationContentState();
}

class _InstallationContentState extends State<InstallationContent> {
  Widget placeholder = Container();

  runInstall() async {
    setState(() {
      placeholder = Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitCubeGrid(
            color: Colors.white,
            size: MediaQuery.of(context).size.height * 0.36,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Installing the system...",
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
              "System installation process have started. You can watch some Richard Stallman until it's complete :)",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 44),
        ],
      );
    });
    await writeConfigurations();
    var rez = await installSystem();
    if (rez != "ok") {
      setState(() {
        placeholder = SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.85,
          child: SingleChildScrollView(
            child: Text(
              rez,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      });
      return;
    }
    setState(() {
      placeholder = Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/refresh.png",
            height: MediaQuery.of(context).size.height * 0.36,
            width: MediaQuery.of(context).size.height * 0.36,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Text(
              "Done",
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
              "Now you can reboot and log into system.",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FmnxTextButton(
            text: "Reboot",
            onPressed: () {
              syscall("reboot ''");
            },
          ),
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () {
      setState(() {
        placeholder = Column(
          key: UniqueKey(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/system.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Run installation",
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
                "Installation usually takes ~ 15-25 minutes, depending on disk and internet connection speed.",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            FmnxTextButton(
              text: "Start",
              onPressed: () {
                runInstall();
              },
            ),
          ],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 644),
          child: placeholder,
        ),
      ),
    );
  }
}
