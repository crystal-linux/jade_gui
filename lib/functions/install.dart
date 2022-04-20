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
    var process =
        //await Process.start('pkexec', ['jade', 'config', '/tmp/jade.json']);
        await Process.start('/opt/jade_gui/scripts/jadeemu.sh', []);
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
  setOutput,
  output,
  running,
  setRunning,
  writeToLog,
) {
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
    isEfi: isEfi,
    bootloader: bootloader,
    bootloaderLocation: isEfi ? "/boot/efi" : disk,
    hostname: hostname,
    ipv6: ipv6,
    enableTimeshift: enableTimeshift,
  );
  String jsonPrefs = jsonEncode(prefs.toJson());
  //writeConfig(jsonPrefs);
  test(setOutput, running, setRunning, jsonPrefs, writeToLog);
  return Column(
    children: [
      Text(
        output.toString().contains("Installation finished! You may reboot now!")
            ? "Installed!"
            : "Installing...",
        style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
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
          //color: Colors.black,
          /*boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
              offset: Offset(-2, 3),
            ),
          ]*/
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
