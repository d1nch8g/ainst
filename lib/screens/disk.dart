import 'package:flutter/material.dart';
import 'package:installer/components/buttons.dart';
import 'package:installer/components/dropdown.dart';
import 'package:installer/constants.dart';
import 'package:installer/screens/software.dart';

class DiskContent extends StatelessWidget {
  const DiskContent({super.key});

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
              width: MediaQuery.of(context).size.width * 0.52,
              child: const Text(
                "Type of filesystem should be chosen depending on type of hard drive you have and it's specs. Default option is 'ext4', but for SSD drives consider using 'btrfs'",
                style: TextStyle(
                  color: Colors.white,
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
                  FleuDropdown(
                    label: 'Installation disk',
                    items: const [
                      '/dev/sda',
                      '/dev/sdb',
                    ],
                    onChanged: (v) {},
                  ),
                  FleuDropdown(
                    label: 'Type of filesystem',
                    items: const [
                      'ext4',
                      'btrfs',
                      'fat32',
                    ],
                    onChanged: (v) {},
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
                FleuTextButton(
                  text: "Next",
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SoftwareContent(),
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
