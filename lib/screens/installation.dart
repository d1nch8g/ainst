import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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

  setDocumentation(String text) {
    setState(() {
      placeholder = DocumentationView(
        documentation: text,
        openSpinner: setSpinner,
      );
    });
  }

  setSpinner() {
    setState(() {
      placeholder = SpinnerView(
        openDocumentation: setDocumentation,
      );
    });
  }

  runInstall() async {
    setState(() {
      placeholder = SpinnerView(
        openDocumentation: setDocumentation,
      );
    });

    var scripts = await getInstallationScripts();
    var rez = await installSystem(scripts);
    if (rez != "ok") {
      setState(() {
        placeholder = ErrorView(errmes: rez);
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
              syscall("reboot");
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

class SpinnerView extends StatelessWidget {
  final void Function(String) openDocumentation;

  const SpinnerView({
    super.key,
    required this.openDocumentation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onPressed: () async {
            var desc = await getDescriptionMarkdownString();
            openDocumentation(desc);
          },
        ),
      ],
    );
  }
}

class ErrorView extends StatelessWidget {
  final String errmes;

  const ErrorView({
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

class DocumentationView extends StatelessWidget {
  final String documentation;
  final void Function() openSpinner;

  const DocumentationView({
    super.key,
    required this.documentation,
    required this.openSpinner,
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
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.56,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.62,
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(primaryColorLight),
                ),
              ),
              child: Markdown(
                data: documentation,
                styleSheet: MarkdownStyleSheet(
                  a: const TextStyle(color: primaryColorLighter),
                  p: const TextStyle(color: primaryColorLight),
                  h2: const TextStyle(color: primaryColorLighter),
                  code: TextStyle(
                    backgroundColor: secondaryColor,
                    fontFamily: 'monospace',
                    fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                    color: primaryColorLighter,
                  ),
                ),
                styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
                onTapLink: (text, href, title) => {
                  launchUrl(Uri.parse(href!)),
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FmnxButton(
          text: "Return back",
          onPressed: () {
            openSpinner();
          },
        ),
      ],
    );
  }
}
