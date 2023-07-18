import 'package:flutter/material.dart';
import 'package:ainst/components/buttons.dart';
import 'package:ainst/components/dropdown.dart';
import 'package:ainst/components/notification.dart';
import 'package:ainst/constants.dart';
import 'package:ainst/screens/installation.dart';
import 'package:ainst/utils/senderr.dart';
import 'package:ainst/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HardwareContent extends StatefulWidget {
  const HardwareContent({super.key});

  @override
  State<HardwareContent> createState() => _HardwareContentState();
}

class _HardwareContentState extends State<HardwareContent> {
  List<String> disks = ["/dev/sda"];
  List<String> gpuDrivers = [
    "All open-source (default)",
    "AMD / ATI (open-source)",
    "Intel (open-source)",
    "Nvidia (proprietary)",
    "VMware / VirtualBox (open-source)",
  ];

  setDisks() async {
    disks = [];
    var rez = await syscall("lsblk");
    if (rez.error) {
      sendErr("stdout: ${rez.stdout}, stderr: ${rez.stderr}");
    }
    for (var line in rez.stdout.split("\n")) {
      if (line.contains("disk") && !line.contains("SWAP")) {
        var name = line.replaceAll(RegExp(" +"), " ").split(" ")[0];
        var size = line.replaceAll(RegExp(" +"), " ").split(" ")[3];
        setState(() {
          disks.add("$name - $size");
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setDisks();
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
              "assets/storage.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Choose hardware parameters",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseDropdown(
                  label: 'Installation disk',
                  items: disks,
                  width: 320,
                  onChanged: (value) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("DISK", value.split(" ")[0]);
                  },
                ),
                const SizedBox(width: 32),
                BaseDropdown(
                  label: 'Graphics drivers',
                  items: gpuDrivers,
                  width: 320,
                  onChanged: (String v) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("GFXDRIVER", v);
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FmnxButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 42),
                const DiskCheckButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiskCheckButton extends StatelessWidget {
  const DiskCheckButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FmnxButton(
      text: "Next",
      onPressed: () async {
        var prefs = await SharedPreferences.getInstance();
        if (prefs.getString("DISK") == null) {
          // ignore: use_build_context_synchronously
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Choose disk for installation.",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        if (prefs.getString("GFXDRIVER") == null) {
          // ignore: use_build_context_synchronously
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Choose graphics drivers.",
                icon: Icons.error,
                duration: Duration(milliseconds: 1342),
              );
            },
          );
          return;
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const InstallationContent(),
        ));
      },
    );
  }
}
