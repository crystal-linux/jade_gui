import 'package:flutter/material.dart';
import 'package:jade_gui/Keymaps/keymaps.dart';
import 'package:jade_gui/classes/keymap.dart';

Keymap chosenLayout = keymaps[0];
String chosenVariant = "none";

String getChosenVariant() {
  return chosenVariant;
}

String getChosenLayout() {
  return chosenLayout.backLayout;
}

Widget variantTemplate(variant, chosenLayout, nextPage) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black45),
          color: const Color.fromARGB(255, 30, 30, 30),
        ),
        child: ElevatedButton(
          onPressed: () {
            chosenVariant = variant;
            nextPage();
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(0, 169, 0, 255),
            shadowColor: const Color.fromARGB(0, 169, 0, 255),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            variant,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget layoutTemplate(keymap, setChosenLayout) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black45),
          color: const Color.fromARGB(255, 30, 30, 30),
        ),
        child: ElevatedButton(
          onPressed: () {
            setChosenLayout(keymap);
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(255, 30, 30, 30),
            shadowColor: const Color.fromARGB(100, 30, 30, 30),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            keymap.layout,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget keyboard(
    nextPage, showVariant, choseLayout, setChosenLayout, chosenLayout) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Please select a keyboard layout',
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 40),
            Expanded(
              child: Container(
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
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    children: keymaps
                        .map<Widget>(
                            (keymap) => layoutTemplate(keymap, setChosenLayout))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: Container(
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
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    children: chosenLayout.variant
                        .map<Widget>((map) =>
                            variantTemplate(map, chosenLayout, nextPage))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
