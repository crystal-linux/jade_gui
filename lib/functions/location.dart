import 'package:flutter/material.dart';
import '../classes/location.dart';

Widget locationTemplate(location) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: ElevatedButton(
      onPressed: () {},
      child: Text(location),
    ),
    //color: Colors.teal[100],
  );
}

Widget location(region, europe) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please choose your Locale',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 169, 0, 255)),
            ),
            Text(
              '$region/',
              style: const TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 169, 0, 255)),
            )
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
          children: options(region, europe),
        ),
      ],
    ),
  );
}

List<Widget> options(region, europe) {
  List<Widget> widget;

  switch (region) {
    case "Europe":
      {
        widget = europe
            .map<Widget>((location) => locationTemplate(location.location))
            .toList();
        break;
      }
    case "Asia":
      {
        widget = europe
            .map<Widget>((location) => locationTemplate(location.location))
            .toList();
        break;
      }
    case "Africa":
      {
        widget = europe
            .map<Widget>((location) => locationTemplate(location.location))
            .toList();
        break;
      }
    case "North America":
      {
        widget = europe
            .map<Widget>((location) => locationTemplate(location.location))
            .toList();
        break;
      }
    case "South America":
      {
        widget = europe
            .map<Widget>((location) => locationTemplate(location.location))
            .toList();
        break;
      }
    default:
      widget = const [
        Text(
          'You should not see this, report this at git.tar.black/crystal/jade_gui',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ];
  }
  // Finally returning a Widget
  return widget;
}
