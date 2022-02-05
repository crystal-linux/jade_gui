import 'package:flutter/material.dart';

String selectedRegion = "";

Widget locationTemplate(next, location) {
  return Container(
    padding: const EdgeInsets.all(8),
    color: const Color.fromARGB(100, 169, 0, 255),
    child: Container(
      padding: const EdgeInsets.all(8),
      color: const Color.fromARGB(100, 169, 0, 255),
      child: ElevatedButton(
        onPressed: () {
          next();
          selectedRegion = location.name;
        },
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color.fromARGB(100, 169, 0, 255),
          padding: const EdgeInsets.all(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(location.name),
          ],
        ),
      ),
    ),
  );
}

Widget region(next, locations) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Please choose your Locale',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 169, 0, 255)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: locations
              .map<Widget>((location) => locationTemplate(next, location))
              .toList(),
        ),
      ],
    ),
  );
}

String getSelectedRegion() {
  return selectedRegion;
}
