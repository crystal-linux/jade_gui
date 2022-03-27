import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

Future<void> getPartitionInfo(currPartition, setState) async {
  final String partitionInfo = await Process.run(
          "/opt/jade_gui/scripts/getPartitionInfo.sh", ['$currPartition'])
      .then((ProcessResult results) {
    return results.stdout;
  });
  setState(partitionInfo);
}

Future<void> getPartitions(setState) async {
  final String partitions =
      await Process.run("/opt/jade_gui/scripts/getPartitions.sh", [])
          .then((ProcessResult result) {
    return result.stdout;
  });
  setState(partitions);
}

Widget partitionTemplate(partition, setPartition, setPartitionInfo) {
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
            setPartition(partition);
            getPartitionInfo(partition, setPartitionInfo);
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color.fromARGB(0, 169, 0, 255),
            shadowColor: const Color.fromARGB(0, 169, 0, 255),
            padding: const EdgeInsets.all(10),
          ),
          child: Text(
            partition,
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

Widget partitioning(partitions, setState, setPartition, next, setPartitionInfo,
    selectedPartition, partitionInfo) {
  return FutureBuilder(
    future: getPartitions(setState),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            .split('\n')
                            .map<Widget>((partition) => partitionTemplate(
                                partition, setPartition, setPartitionInfo))
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
                          Text(
                            selectedPartition,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 169, 0, 255),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Size: $partitionInfo',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 169, 0, 255),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Image(image: AssetImage('assets/jade_logo.png')),
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
                          backgroundColor:
                              const Color.fromARGB(255, 169, 0, 255),
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
    },
  );
}
