import 'package:flutter/material.dart';
import 'package:jade_gui/classes/installPrefs.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';
import 'dart:convert';
import 'dart:io';

test(setOutput) async {
  var process = await Process.start('./scripts/jadeemu.sh', []);
  process.stdout.transform(utf8.decoder).forEach(setOutput);
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
) {
  test(setOutput);
  installPrefs prefs = installPrefs(
    locale: locale,
    keymap: keymap,
    layout: layout,
    username: username,
    password: password,
    enableSudo: enableSudo,
    rootPass: rootPass,
    desktop: desktop,
    disk: disk,
    isEfi: isEfi,
    bootloader: bootloader,
    hostname: hostname,
    ipv6: ipv6,
    enableTimeshift: enableTimeshift,
  );
  String jsonPrefs = jsonEncode(prefs.toJson());
  print(jsonPrefs);
  return Column(
    children: [
      const Text(
        'Installing...',
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      const SizedBox(
        height: 20,
      ),
      SingleChildScrollView(
        child: Text(output,
            style: const TextStyle(
              color: Color.fromARGB(255, 169, 0, 255),
            )),
      ),
    ],
  );
}
