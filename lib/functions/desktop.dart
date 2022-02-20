import 'package:flutter/material.dart';
import 'package:jade_gui/desktops/desktops.dart';

Widget desktopTemplate(desktop, setDesktop) {
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
            setDesktop(desktop);
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(0, 169, 0, 255),
            shadowColor: const Color.fromARGB(0, 169, 0, 255),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            desktop.name,
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

Widget desktopView(currDesktop, setDesktop, next) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Please select a Desktop',
        style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255)),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    children: desktops
                        .map<Widget>(
                            (desktop) => desktopTemplate(desktop, setDesktop))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Currently chosen Desktop: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 169, 0, 255),
                      ),
                    ),
                    Text(
                      currDesktop.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 169, 0, 255),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image(image: AssetImage(currDesktop.imageurl)),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const SizedBox(width: 60),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      next();
                    },
                    child: const Text(
                      'Next',
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 169, 0, 255),
                      minimumSize: const Size(100, 50),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(width: 30),
            ],
          ),
          const SizedBox(height: 7)
        ],
      ),
    ],
  );
}
