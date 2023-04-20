import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/notification.dart';
import 'package:installer/components/textfield.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/language.dart';
import 'package:installer/utils/connect.dart';

class WifiContent extends StatefulWidget {
  const WifiContent({super.key});

  @override
  State<WifiContent> createState() => _WifiContentState();
}

class _WifiContentState extends State<WifiContent> {
  List<Widget> wifibuttons = [
    const SpinKitCircle(color: Colors.white),
  ];
  Widget currImg = Image.asset(
    "assets/wifi.png",
    height: 96,
  );

  updateWifiList() async {
    var list = await netscan();
    List<Widget> updatedWifis = [];
    for (var wifi in list) {
      updatedWifis.add(TextButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.55),
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: backgroundColor,
                title: ConnectWidget(
                  name: wifi,
                  connectCallback: () {
                    setState(() {
                      currImg = Image.asset(
                        "assets/check.png",
                        key: UniqueKey(),
                        height: 96,
                      );
                    });
                  },
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 24),
              const Icon(
                Icons.wifi,
                color: Colors.white,
              ),
              const SizedBox(width: 24),
              Text(
                wifi,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ));
    }
    setState(() {
      wifibuttons = updatedWifis;
    });
  }

  @override
  void initState() {
    super.initState();
    updateWifiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 644),
              child: currImg,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Connect to network",
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
                "Connect to wireless network, or establish wired connection, then press 'Next'",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: secondaryColor),
              ),
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.44,
              child: ListView(
                children: wifibuttons,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FmnxTextButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 42),
                FmnxTextButton(
                  text: "Next",
                  onPressed: () async {
                    var ok = await netcheck();
                    if (ok) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LanguageContent(),
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return const NotificationPopup(
                            message: "Connect to network",
                            icon: Icons.error,
                            duration: Duration(milliseconds: 1342),
                          );
                        },
                      );
                      return;
                    }
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

class ConnectWidget extends StatefulWidget {
  final String name;
  final void Function() connectCallback;
  const ConnectWidget({
    super.key,
    required this.name,
    required this.connectCallback,
  });

  @override
  State<ConnectWidget> createState() => _ConnectWidgetState();
}

class _ConnectWidgetState extends State<ConnectWidget> {
  final TextEditingController controller = TextEditingController();
  Widget placeholder = SizedBox(
    height: 54,
    child: TextForm(
      hint: "Enter password",
      controller: TextEditingController(),
      password: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      placeholder = SizedBox(
        height: 54,
        child: TextForm(
          hint: "password",
          controller: controller,
          password: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter password",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 622),
            child: placeholder,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FmnxTextButton(
                text: "Close",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 42),
              FmnxTextButton(
                text: "Connect",
                onPressed: () async {
                  setState(() {
                    placeholder = const SpinKitChasingDots(
                      color: Colors.white,
                      size: 54,
                    );
                  });
                  var rez = await netconnect(widget.name, controller.text);
                  if (rez) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    widget.connectCallback();
                    return;
                  } else {
                    setState(() {
                      placeholder = const SizedBox(
                        height: 54,
                        child: Text(
                          "Password incorrect",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 1234), () {
                        setState(() {
                          placeholder = SizedBox(
                            height: 54,
                            child: TextForm(
                              hint: "password",
                              controller: controller,
                              password: true,
                            ),
                          );
                        });
                      });
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
