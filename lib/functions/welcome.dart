import 'package:flutter/material.dart';
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:open_url/open_url.dart';
import 'dart:math';

String getKey(int length, String key, setState) {
  if (key == "" || key.length < length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random r = Random();
    String key = String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
    setState(key);
    print(key);
    return key;
  }
  print(key);
  return key;
}

Widget welcome(
  next,
  connected,
  localIp,
  key,
  setState,
) {
  List ipSplit = localIp.split('.');
  String name = "crystal" + ipSplit.last;
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
            onPressed: connected ? next : null,
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
                children: [
                  const SizedBox(height: 20),
                  const Text("Start the installation",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  const Image(
                    image: AssetImage(
                      'assets/jade_logo.png',
                    ),
                    height: 400,
                    fit: BoxFit.scaleDown,
                  ),
                  Visibility(
                    visible: !connected,
                    child: const Text(
                      "You are not connected to the internet!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
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
          style: TextStyle(fontSize: 20, color: Colors.white)),
      const SizedBox(height: 20),
      Tooltip(
        message: "The qr code to scan for jade_batch, click to find out more.",
        child: ElevatedButton(
          onPressed: () {
            openUrl("https://wiki.getcryst.al/index.php/Jade_batch");
          },
          style: TextButton.styleFrom(
            primary: const Color.fromARGB(0, 23, 23, 23),
            backgroundColor: const Color.fromARGB(0, 23, 23, 23),
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          child: QrImage(
            data: "{\"ip\":\"$localIp\",\"name\":\"$name\",\"key\":\"" +
                getKey(32, key, setState) +
                "\"}",
            embeddedImage: const AssetImage("assets/jade_logo.png"),
            foregroundColor: Colors.white,
            size: 150.150,
          ),
        ),
      ),
    ],
  );
}
