import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ainst/components/buttons.dart';
import 'package:ainst/constants.dart';
import 'package:ainst/utils/install.dart';
import 'package:ainst/utils/syscall.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
          FmnxButton(
            text: "Open documentation",
            onPressed: () {
              launchUrl(Uri.parse(
                'https://fmnx.su/core/iso/src/branch/main/docs/RAEADME.md',
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
        placeholder = ErrorWindow(errmes: rez);
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
          FmnxButton(
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
            FmnxButton(
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

class ErrorWindow extends StatelessWidget {
  final String errmes;

  const ErrorWindow({
    super.key,
    required this.errmes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColorLight),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.85,
            child: Theme(
              data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(primaryColorLight),
              )),
              child: SingleChildScrollView(
                child: Text(
                  errmes,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FmnxButton(
              text: "Copy error",
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: errmes));
              },
            ),
            const SizedBox(width: 24),
            FmnxButton(
              text: "Open issue",
              onPressed: () {
                launchUrl(Uri.parse(
                  'https://fmnx.su/core/ainst/issues/new',
                ));
              },
            ),
          ],
        )
      ],
    );
  }
}
