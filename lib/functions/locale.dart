import 'package:flutter/material.dart';
import 'package:jade_gui/locales/locales.dart';
import 'package:jade_gui/classes/location.dart';

Local chosenLocation = locations[0];
Location chosenRegion = locations[0].location[0];

String getChosenLocation() {
  return chosenLocation.name;
}

Location getSelectedLocPack() {
  return chosenRegion;
}

Widget regionTemplate(variant, chosenLayout, nextPage, writeToLog) {
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
            chosenRegion = variant;
            writeToLog("Chosen Region: ${chosenRegion.location}");
            nextPage();
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(0, 169, 0, 255),
            shadowColor: const Color.fromARGB(0, 169, 0, 255),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            variant.location,
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

Widget locationTemplate(location, setChosenLocation, writeToLog) {
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
            setChosenLocation(location);
            writeToLog("Chosen location: ${location.name}");
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(255, 30, 30, 30),
            shadowColor: const Color.fromARGB(100, 30, 30, 30),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            location.name,
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

Widget locale(nextPage, showRegion, choseLocation, setChosenLocation,
    Local chosenLocation, writeToLog) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Please select a Time zone',
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
                    children: locations
                        .map<Widget>((keymap) => locationTemplate(
                            keymap, setChosenLocation, writeToLog))
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
                    children: chosenLocation.location
                        .map<Widget>((map) => regionTemplate(
                            map, chosenLocation, nextPage, writeToLog))
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
