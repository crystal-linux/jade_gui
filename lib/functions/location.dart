import 'package:flutter/material.dart';
import '../Locales/locales.dart';

Widget locationTemplate(location, nextSlide) {
  return Container(
    padding: const EdgeInsets.all(8),
    child: ElevatedButton(
      onPressed: () {
        nextSlide();
      },
      child: Column(
        children: [
          Image(
            image: AssetImage(
              '${location.image}',
            ),
            height: 300,
            width: 300,
          ),
          Text(location.location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ),
    //color: Colors.teal[100],
  );
}

Widget location(region, nextSlide) {
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
          children: options(region, locations, nextSlide),
        ),
      ],
    ),
  );
}

List<Widget> options(region, locations, nextSlide) {
  List<Widget> widget;

  switch (region) {
    case "Africa":
      {
        widget = locations[0]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "America":
      {
        widget = locations[1]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Antarctica":
      {
        widget = locations[2]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Arctic":
      {
        widget = locations[3]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Asia":
      {
        widget = locations[4]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Atlantic":
      {
        widget = locations[5]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Australia":
      {
        widget = locations[6]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Brazil":
      {
        widget = locations[7]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Canada":
      {
        widget = locations[8]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Chile":
      {
        widget = locations[9]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Europe":
      {
        widget = locations[10]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Indian":
      {
        widget = locations[11]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Mexico":
      {
        widget = locations[12]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "Pacific":
      {
        widget = locations[13]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
            .toList();
        break;
      }
    case "US":
      {
        widget = locations[14]
            .location
            .map<Widget>((location) => locationTemplate(location, nextSlide))
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
