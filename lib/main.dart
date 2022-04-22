import 'package:flutter/material.dart';
import 'package:jade_gui/functions/welcome.dart';
import 'package:jade_gui/functions/locale.dart';
import 'package:jade_gui/functions/keyboard.dart';
import 'package:jade_gui/functions/users.dart';
import 'package:jade_gui/functions/desktop.dart';
import 'package:jade_gui/functions/partition.dart';
import 'package:jade_gui/functions/summary.dart';
import 'package:jade_gui/functions/misc.dart';
import 'package:jade_gui/functions/install.dart';
import 'package:jade_gui/classes/keymap.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/desktops/desktops.dart';
import 'package:window_size/window_size.dart';

import 'dart:io';

Map env = Platform.environment;

Future<void> checkIsEfi(
  setState,
  runningEfi,
  setRunningEfi,
) async {
  if (!runningEfi) {
    final String scriptOutput =
        await Process.run("/opt/jade_gui/scripts/checkEfi.sh", [])
            .then((ProcessResult result) {
      return result.stdout;
    });
    bool isEfi = scriptOutput == "UEFI\n" ? true : false;
    debugPrint(isEfi.toString());
    debugPrint(scriptOutput);

    setState(isEfi);
    setRunningEfi();
  }
}

Future<void> checkConnected(
  setState,
) async {
  final String scriptOutput =
      await Process.run("/opt/jade_gui/scripts/checkNetwork.sh", [])
          .then((ProcessResult result) {
    return result.stdout;
  });
  bool connected = scriptOutput.contains("disconnected") ? false : true;
  setState(connected);
}

Future<void> writeToLog(String message) async {
  await File('${env["HOME"]}/jade_log.txt')
      .readAsString()
      .then((String contents) {
    File("jade_log.txt").writeAsString(contents + "\n" + message);
  });
}

void setWindowSize() {
  setWindowMinSize(Size(0, 0));
  setWindowMaxSize(Size(1300, 870));
}

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Jadegui(),
      ),
    );

Future<void> setPassword(clearPass, setState) async {
  final String password =
      await Process.run("openssl", ["passwd", "-crypt", clearPass])
          .then((ProcessResult result) {
    return result.stdout;
  });
  debugPrint(password);
  setState(password.replaceAll("\n", ""));
}

class Jadegui extends StatefulWidget {
  const Jadegui({Key? key}) : super(key: key);

  @override
  _JadeguiState createState() => _JadeguiState();
}

class _JadeguiState extends State<Jadegui> {
  var file = File('${env["HOME"]}/jade_log.txt').writeAsString("");
  int _selectedIndex = 0;
  bool nextpage = false;
  bool choseLayout = false;
  bool choseRegion = false;
  bool enableSudo = true;
  bool enableRoot = false;
  bool isEfi = false;
  bool ipv6 = false;
  bool enableTimeshift = true;
  bool connected = false;
  bool running = false;
  bool runningInfo = false;
  bool runningPart = false;
  bool runningSum = false;
  bool runningEfi = false;
  String clearPass = "";
  String password = "";
  String confirmPassword = "";
  String username = "";
  String rootPass = "";
  String confirmRootPass = "";
  String disks = "";
  String selectedDisk = "";
  String partitionInfo = "";
  String _diskType = "";
  String hostname = "";
  String output = "";
  Desktop currDesktop = desktops[0];
  Keymap chosenLayout = Keymap();

  @override
  Widget build(BuildContext context) {
    setWindowSize();
    checkConnected(
      (value) {
        setState(() {
          connected = value;
        });
      },
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: const Color.fromARGB(255, 27, 27, 27),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.home,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Welcome',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Location',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.keyboard_alt_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.keyboard,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Keymap',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.person_add_alt_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.person_add_alt,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Users',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.desktop_windows_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.desktop_windows,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Desktop',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.miscellaneous_services_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.miscellaneous_services,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Misc',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.pie_chart_outline,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.pie_chart,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Partitioning',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.summarize_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.summarize,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Summary',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.download_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.download,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Installing',
                  style: TextStyle(
                      color: Color.fromARGB(100, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: condition(),
          ),
        ],
      ),
    );
  }

  bool loadnextpage(region) {
    bool next = false;
    if (region != "") {
      setState(() {
        next = true;
      });
    } else {
      setState(() {
        next = true;
      });
    }
    return next;
  }

  Widget condition() {
    Widget widget;
    double logicWidth = 1300;
    double logicHeight = 870;
    switch (_selectedIndex) {
      case 0:
        widget = SizedBox(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: welcome(
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
                connected,
              ),
            ),
          ),
        );
        break;
      case 1:
        widget = locale(
          () {
            setState(() {
              _selectedIndex = _selectedIndex + 1;
            });
          },
          () {
            setState(() {
              choseRegion = true;
            });
          },
          choseRegion,
          (location) {
            setState(() {
              chosenLocation = location;
            });
          },
          chosenLocation,
          (value) {
            writeToLog(value);
          },
        );
        //writeToLog("locale: $region");

        break;
      case 2:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: keyboard(
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
                () {
                  setState(() {
                    choseLayout = true;
                  });
                },
                choseLayout,
                (layout) {
                  setState(() {
                    chosenLayout = layout;
                  });
                },
                chosenLayout,
                (value) {
                  writeToLog(value);
                },
              ),
            ),
          ),
        );
        break;
      case 3:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: users(
                (value) {
                  setState(() {
                    enableSudo = value;
                    writeToLog("Enable sudo: $enableSudo");
                  });
                },
                enableSudo,
                (String? value) {
                  setState(() {
                    if (value != null) {
                      setPassword(value, (String encPass) {
                        setState(() {
                          password = encPass;
                          clearPass = value;
                        });
                      });
                    }
                  });
                },
                (value) {
                  setState(() {
                    confirmPassword = value;
                  });
                },
                clearPass,
                confirmPassword,
                (value) {
                  setState(() {
                    username = value;
                    writeToLog("Username: $username");
                  });
                },
                username,
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
              ),
            ),
          ),
        );
        break;
      case 4:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: desktopView(
                currDesktop,
                (selectedDesktop) {
                  setState(() {
                    currDesktop = selectedDesktop;
                    writeToLog("Desktop: ${selectedDesktop.name}");
                  });
                },
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
              ),
            ),
          ),
        );
        break;
      case 5:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: misc(
                (value) {
                  setState(() {
                    ipv6 = value;
                    writeToLog("IPv6: $ipv6");
                  });
                },
                (value) {
                  setState(() {
                    hostname = value;
                    writeToLog("Hostname: $hostname");
                  });
                },
                (value) {
                  setState(() {
                    enableTimeshift = value;
                    writeToLog("Enable timeshift: $enableTimeshift");
                  });
                },
                ipv6,
                hostname,
                enableTimeshift,
                (value) {
                  setState(() {
                    enableRoot = value;
                    writeToLog("Enable root: $enableRoot");
                  });
                },
                enableRoot,
                (String? value) {
                  setState(() {
                    if (value != null) {
                      rootPass = value;
                    }
                  });
                },
                (value) {
                  setState(() {
                    confirmRootPass = value;
                  });
                },
                rootPass,
                confirmRootPass,
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
              ),
            ),
          ),
        );
        break;
      case 6:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: partitioning(
                disks,
                (value) {
                  setState(() {
                    disks = value;
                    writeToLog("Disks:widget $disks");
                  });
                },
                (value) {
                  setState(() {
                    selectedDisk = value;
                    writeToLog("Selected disk: $selectedDisk");
                  });
                },
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
                (value) {
                  setState(() {
                    partitionInfo = value;
                    writeToLog("Partition info: $partitionInfo");
                  });
                },
                selectedDisk,
                partitionInfo,
                runningPart,
                () {
                  setState(() {
                    runningPart = true;
                  });
                },
                runningInfo,
                () {
                  setState(() {
                    runningInfo = true;
                  });
                },
              ),
            ),
          ),
        );
        break;
      case 7:
        checkIsEfi(
            (value) {
              setState(() {
                isEfi = value;
              });
              writeToLog("Is efi: $isEfi");
            },
            runningEfi,
            () {
              setState(() {
                runningEfi = true;
              });
            });
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: summary(
                getSelectedLocPack(),
                getChosenLayout(),
                getChosenVariant(),
                username,
                enableSudo,
                enableRoot,
                currDesktop,
                selectedDisk,
                isEfi,
                "grub-efi",
                hostname,
                ipv6,
                enableTimeshift,
                _diskType,
                partitionInfo,
                (value) {
                  setState(() {
                    _diskType = value;
                    //writeToLog("diskType: $_diskType");
                  });
                },
                () {
                  setState(() {
                    _selectedIndex = _selectedIndex + 1;
                  });
                },
                runningSum,
                () {
                  setState(() {
                    runningSum = true;
                  });
                },
              ),
            ),
          ),
        );
        break;
      case 8:
        widget = SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: logicWidth,
              height: logicHeight,
              child: install(
                getSelectedLocPack(),
                getChosenLayout(),
                getChosenVariant(),
                username,
                password,
                enableSudo,
                rootPass,
                currDesktop,
                selectedDisk,
                isEfi,
                isEfi ? "grub-efi" : "grub-legacy",
                hostname,
                ipv6,
                enableTimeshift,
                (value) {
                  setState(() {
                    if (value.compareTo(output) == 1) {
                      writeToLog(value.replaceAll(output, ""));
                    }
                    output = output + "\n" + value;
                  });
                },
                output,
                running,
                (value) {
                  setState(() {
                    running = value;
                  });
                },
                writeToLog,
              ),
            ),
          ),
        );
        break;
      default:
        widget = const Text(
          'You should not see this, report this at https://git.tar.black/crystal/jade_gui',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        );
    }

    // Finally returning a Widget
    return widget;
  }
}
