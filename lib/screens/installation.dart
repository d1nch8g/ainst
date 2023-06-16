import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ainst/components/buttons.dart';
import 'package:ainst/constants.dart';
import 'package:ainst/utils/install.dart';
import 'package:ainst/utils/syscall.dart';
import 'package:url_launcher/url_launcher.dart';

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
              "System installation process have started. You can learn more about distro on the page below.",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FmnxTextButton(
            text: "Open documentation",
            onPressed: () {
              launchUrl(Uri.parse(
                'https://fmnx.su/core/iso/wiki/About-distribution',
              ));
            },
          ),
        ],
      );
    });
    var scripts = await getInstallationScripts();
    var rez = await installSystem(scripts);
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
            "assets/reboot.png",
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
              "assets/install.png",
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
