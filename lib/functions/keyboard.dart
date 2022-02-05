import 'package:flutter/material.dart';
import 'package:jade_gui/Keymaps/keymaps.dart';

Widget keyboard(next) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Please select a keyboard layout',
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 169, 0, 255)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [],
        ),
      ],
    ),
  );
}
