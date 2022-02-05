import 'package:flutter/material.dart';

Widget layout(keymap, chosenLayout, showVariant) {
  return Container(
    color: const Color.fromARGB(100, 169, 0, 255),
    padding: const EdgeInsets.all(8),
    child: ElevatedButton(
      onPressed: () {
        chosenLayout = keymap;
        showVariant();
      },
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: const Color.fromARGB(100, 169, 0, 255),
        padding: const EdgeInsets.all(10),
      ),
      child: Text(
        keymap.layout,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
