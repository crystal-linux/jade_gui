import 'package:flutter/material.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';
import 'dart:io';

Widget infoTextTemplate(infoSection, infoText) {
  return Text(
    '$infoSection: $infoText',
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 169, 0, 255),
    ),
  );
}

Future<void> getDiskType(setState, disk) async {
  final String partitions =
      await Process.run("/opt/jade_gui/scripts/getDiskType.sh", [disk])
          .then((ProcessResult result) {
    return result.stdout;
  });
  setState(partitions);
}

String diskType(String disk, String diskType) {
  if (disk.contains("sd") && diskType.contains("0")) {
    return 'SSD';
  } else if (disk.contains("sd") && diskType.contains("1")) {
    return 'HDD';
  } else if (disk.contains("nvme") && diskType.contains("0")) {
    return 'NVME SSD';
  } else if (disk.contains("nvme") && diskType.contains("1")) {
    return 'NVME HDD';
  } else {
    return 'Unknown, report at https://git.tar.black/crystal/jade-gui';
  }
}

Widget summary(
  String keymap,
  String layout,
  bool enableSudo,
  bool enableRoot,
  String username,
  String disk,
  String diskSize,
  Desktop currDesktop,
  Location locale,
  nextPage,
  setDiskType,
  String rotational,
  bool isEfi,
) {
  getDiskType(setDiskType, disk);
  return Column(
    children: [
      const Text(
        'Installation Summary',
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 30, 30, 30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(-2, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Location:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 10),
                  infoTextTemplate("Region", locale.region),
                  const SizedBox(height: 10),
                  infoTextTemplate("Location", locale.location),
                  const SizedBox(height: 10),
                  infoTextTemplate("locale", locale.locale),
                ],
              ),
            ),
            //const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 30, 30, 30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(-2, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Keyboard:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 10),
                  infoTextTemplate("Keymap", keymap),
                  const SizedBox(height: 10),
                  infoTextTemplate("Layout", layout),
                ],
              ),
            ),
            //const SizedBox(height: 0),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 30, 30, 30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(-2, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "User:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 10),
                  infoTextTemplate("Username", username),
                  const SizedBox(height: 10),
                  infoTextTemplate("Enable sudo", enableSudo.toString()),
                  const SizedBox(height: 10),
                  infoTextTemplate("Enable root", enableRoot.toString()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 30, 30, 30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(-2, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Desktop:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currDesktop.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                color: const Color.fromARGB(255, 30, 30, 30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(-2, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Disk:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 169, 0, 255),
                    ),
                  ),
                  const SizedBox(height: 10),
                  infoTextTemplate("Disk", disk),
                  const SizedBox(height: 10),
                  infoTextTemplate("Disk Size", diskSize),
                  const SizedBox(height: 10),
                  infoTextTemplate("Disk Type", diskType(disk, rotational)),
                  const SizedBox(height: 10),
                  infoTextTemplate("Boot Type", isEfi ? "UEFI" : "Legacy")
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 60),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      nextPage();
                    },
                    child: const Text(
                      'Install',
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 169, 0, 255),
                      minimumSize: const Size(100, 50),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 7)
        ],
      ),
    ],
  );
}
