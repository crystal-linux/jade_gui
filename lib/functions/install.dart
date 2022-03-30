import 'package:flutter/material.dart';
import 'package:jade_gui/classes/installPrefs.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';

Widget install(
  String keymap,
  String layout,
  bool enableSudo,
  bool enableRoot,
  String username,
  String disk,
  Desktop currDesktop,
  Location locale,
) {
  installPrefs prefs = installPrefs(
      locale: locale,
      keymap: keymap,
      layout: layout,
      username: username,
      enableSudo: enableSudo,
      enableRoot: enableRoot,
      desktop: currDesktop);
  return Column(
    children: [
      const Text(
        'Installing...',
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
    ],
  );
}
