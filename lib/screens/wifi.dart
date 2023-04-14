import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/constants.dart';
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

  updateWifiList() async {
    var list = await netscan();
    List<Widget> updatedWifis = [];
    for (var wifi in list) {
      updatedWifis.add(IconButton(
        onPressed: () {},
        icon: Row(
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
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
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
            Image.asset(
              "assets/wifi.png",
              height: MediaQuery.of(context).size.height * 0.12,
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
                "First you need to connect to some network to continue installation.",
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
                    Navigator.pop(context);
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
