import 'package:flutter/material.dart';
import 'package:jade_gui/classes/install_prefs.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';
import 'dart:convert';
import 'dart:io';

test(setOutput, running, setRunning, config, writeToLog) async {
  if (!running) {
    const filename = "/tmp/jade.json";
    await File(filename).writeAsString(config);
    writeToLog("Json config: $config");
    var process = await Process.start('pkexec', ['jade', 'config', filename]);
    //var process = await Process.start('/opt/jade_gui/scripts/jadeemu.sh', []);
    process.stdout.transform(utf8.decoder).forEach(setOutput);
    setRunning(true);
  }
}

Widget install(
    Location locale,
    String keymap,
    String layout,
    String username,
    String password,
    bool enableSudo,
    String rootPass,
    Desktop desktop,
    String disk,
    bool isEfi,
    String bootloader,
    String hostname,
    bool ipv6,
    bool enableTimeshift,
    bool enableFlatpak,
    bool enableUnakite,
    String unakiteRoot,
    String unakiteBootDev,
    String unakiteEfiDir,
    String crystalRoot,
    String kernel,
    setOutput,
    output,
    running,
    setRunning,
    writeToLog,
    partitions,
    manual) {
  List<String> partsParsed = <String>[];

  for (var part in partitions) {
    if (part.mountpoint != "none" && part.filesystem != "none") {
      if (part.mountpoint == "unakite") {
        partsParsed.add("none:${part.partition}:btrfs");
      } else {
        partsParsed
            .add("/mnt${part.mountpoint}:${part.partition}:${part.filesystem}");
      }
    }
  }

  InstallPrefs prefs = InstallPrefs(
    locale: locale,
    keymap: keymap,
    layout: layout,
    username: username,
    password: password,
    enableSudo: enableSudo,
    rootPass: rootPass,
    desktop: desktop,
    disk: disk.replaceAll("/dev/", ""),
    manualPartitioning: manual,
    partitions: partsParsed,
    isEfi: isEfi,
    bootloader: bootloader,
    bootloaderLocation: isEfi ? "/boot/efi" : disk,
    hostname: hostname,
    ipv6: ipv6,
    enableTimeshift: enableTimeshift,
    enableFlatpak: enableFlatpak,
    enableUnakite: enableUnakite,
    unakiteRoot: unakiteRoot,
    unakiteBootDev: unakiteBootDev,
    unakiteEfiDir: unakiteEfiDir,
    crystalRoot: crystalRoot,
    kernel: kernel,
  );
  String jsonPrefs = jsonEncode(prefs.toJson());
  //writeConfig(jsonPrefs);
  test(setOutput, running, setRunning, jsonPrefs, writeToLog);
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            output
                    .toString()
                    .contains("Installation finished! You may reboot now!")
                ? "Installed!"
                : " Installing...",
            style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 169, 0, 255)),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      const SizedBox(width: 40),
      Container(
        width: 1000,
        height: 500,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
          color: const Color.fromARGB(255, 15, 15, 15),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Text(
            output,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Monospace',
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        output.toString().contains("Installation finished! You may reboot now!")
            ? "Installation finished! You may reboot now!"
            : "This may take a while...",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 169, 0, 255),
        ),
      ),
      Text(
        output.toString().contains("Installation finished! You may reboot now!")
            ? "You can now close this window and reboot your computer."
            : "Please do not close this window until the installation is finished.",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 169, 0, 255),
        ),
      ),
    ],
  );
}
