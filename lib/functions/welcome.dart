import 'package:flutter/material.dart';
import 'package:jade_gui/main.dart';

Widget welcome(next) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/welcome-bg-alt.png'),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Welcome to Jade',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 169, 0, 255)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Installing crystal made easy',
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 169, 0, 255),
              ),
            ),
          ],
        ),
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
                      child: const Text('Start'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 169, 0, 255),
                        minimumSize: const Size(80, 50),
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
    ),
  );
}
