import 'package:flutter/material.dart';

String selectedRegion = "";
Widget region(next) {
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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  next();
                  selectedRegion = "Europe";
                },
                child: Text('Europe'),
              ),
              //color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('English'),
              ),
              //color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('English'),
              ),
              //color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('English'),
              ),
              //color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('English'),
              ),
              //color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('English'),
              ),
              //color: Colors.teal[100],
            ),
          ],
        ),
      ],
    ),
  );
}

String getSelectedRegion() {
  return selectedRegion;
}
