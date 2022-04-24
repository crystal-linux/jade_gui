import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jade_gui/classes/partition.dart';

Widget partitionTemplate(partition, runningInfo, setRunningInfo, mountpoints,
    setPartitionMountpoint) {
  String mount = "none";
  if (partition().partition != "") {
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
            child: Row(
              children: [
                Text(
                  partition().partition,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Expanded(
                  child: Container(),
                ),
                DropdownButton<String>(
                  value: partition().mountpoint,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setPartitionMountpoint(
                        partition(), newValue == "" ? "none" : newValue);
                    mount = newValue == "" ? "none" : newValue!;
                    print(partition().mountpoint);
                  },
                  items:
                      mountpoints.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )),
        const SizedBox(height: 10),
      ],
    );
  } else {
    return const SizedBox(height: 0);
  }
}

Widget manualPartitioning(partitions, setState, runningPart, setRunningPart,
    runningInfo, setRunningInfo, setPartitionMountpoint, setManual, next) {
  var mountpoints = <String>[
    "none",
    "/",
    "/boot",
    "/boot/efi",
    "/home",
    "/opt",
    "/tmp",
    "/usr",
    "/var"
  ];
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Please select a disk to install to',
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
            const SizedBox(width: 100),
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
                    children: partitions
                        .map<Widget>(
                          (partition) => partitionTemplate(
                            () {
                              return partition;
                            },
                            runningInfo,
                            setRunningInfo,
                            mountpoints,
                            setPartitionMountpoint,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 100),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
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
                    children: [
                      const Text(
                        'Currently chosen Disk: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 169, 0, 255),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "selectedPartition",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 169, 0, 255),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Size: diskInfo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 169, 0, 255),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Image(image: AssetImage('assets/jade_logo.png')),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black45),
                          color: const Color.fromARGB(255, 30, 30, 30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setManual(false);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(0, 169, 0, 255),
                            shadowColor: const Color.fromARGB(0, 169, 0, 255),
                            padding: const EdgeInsets.all(10),
                          ),
                          child: const Text(
                            "Auto Partitioning",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
