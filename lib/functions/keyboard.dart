import 'package:flutter/material.dart';
import 'package:jade_gui/Keymaps/keymaps.dart';
import 'package:jade_gui/classes/keymap.dart';
import 'package:jade_gui/functions/keymap/variant.dart';

Keymap chosenLayout = Keymap();

String getChosenLayout() {
  return chosenLayout.backLayout;
}

Widget layoutOrVariant(showVariant, keymap, choseLayout, nextPage) {
  if (choseLayout && keymap == chosenLayout) {
    return variant(chosenLayout, nextPage);
  } else {
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
}

Widget layoutTemplate(Keymap keymap, showVariant, choseLayout, nextPage) {
  return Container(
      color: const Color.fromARGB(100, 169, 0, 255),
      padding: const EdgeInsets.all(8),
      child: layoutOrVariant(showVariant, keymap, choseLayout, nextPage));
}

Widget keyboard(nextPage, showVariant, choseLayout) {
  return SingleChildScrollView(
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
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: keymaps
              .map<Widget>((keymap) =>
                  layoutTemplate(keymap, showVariant, choseLayout, nextPage))
              .toList(),
        ),
      ],
    ),
  );
}
