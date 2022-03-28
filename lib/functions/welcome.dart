import 'package:flutter/material.dart';
import 'dart:io';

Widget welcome(next) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 50),
      const Text(
        'Welcome to Crystal Linux',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 169, 0, 255),
        ),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(0, 23, 23, 23),
              backgroundColor: const Color.fromARGB(0, 23, 23, 23),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              exit(0);
            },
            child: Container(
              width: 500,
              height: 500,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(height: 20),
                  Text("Try Crystal Linux without installing",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 5),
                  Image(
                    image: AssetImage(
                      'assets/crystal-logo-minimal.png',
                    ),
                    height: 400,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: TextButton.styleFrom(
              primary: const Color.fromARGB(0, 23, 23, 23),
              backgroundColor: const Color.fromARGB(0, 23, 23, 23),
              elevation: 0,
              padding: EdgeInsets.zero,
            ),
            onPressed: next,
            child: Container(
              width: 500,
              height: 500,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(height: 20),
                  Text("Start the installation",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  SizedBox(height: 5),
                  Image(
                    image: AssetImage(
                      'assets/jade_logo.png',
                    ),
                    height: 400,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      const Text(
          "Starting Crystal linux without installing will not change anything on your computer,",
          style: TextStyle(fontSize: 20, color: Colors.white)),
      const Text(
          "it's recommended to try that first to see if everything works",
          style: TextStyle(fontSize: 20, color: Colors.white))
    ],
  );
}
