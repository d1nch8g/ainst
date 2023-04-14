import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/dropdown.dart';
import 'package:installer/components/notification.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/installation.dart';
import 'package:installer/utils/senderr.dart';
import 'package:installer/utils/syscall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiskContent extends StatefulWidget {
  const DiskContent({super.key});

  @override
  State<DiskContent> createState() => _DiskContentState();
}

class _DiskContentState extends State<DiskContent> {
  List<String> disks = ["/dev/sda"];

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
              "assets/disk.png",
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: const Text(
                "Choose a disk and type of file system",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FleuBaseDropdown(
                    label: 'Installation disk',
                    items: disks,
                    onChanged: (value) async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("disk", value.split(" ")[0]);
                    },
                  ),
                ],
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
    return FleuTextButton(
      text: "Next",
      onPressed: () async {
        var prefs = await SharedPreferences.getInstance();
        if (prefs.getString("disk") == null) {
          // ignore: use_build_context_synchronously
          showBottomSheet(
            context: context,
            builder: (context) {
              return const NotificationPopup(
                message: "Choose at least one disk for installtion",
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
