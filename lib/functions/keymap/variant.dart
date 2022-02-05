import 'package:flutter/material.dart';

String chosenVariant = "none";

String getChosenVariant() {
  return chosenVariant;
}

Widget variantButton(variant, nextPage) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      ElevatedButton(
        onPressed: () {
          chosenVariant = variant;
          nextPage();
        },
        child: Text(variant),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color.fromARGB(100, 169, 0, 255),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget variant(keymap, nextPage) {
  return Container(
    padding: const EdgeInsets.all(8),
    color: const Color.fromARGB(100, 169, 0, 255),
    child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: keymap.variant
              .map<Widget>((variant) => variantButton(variant, nextPage))
              .toList()),
    ),
  );
}
