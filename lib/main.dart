import 'package:flutter/material.dart';
import 'package:jade_gui/functions/location/location.dart';
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

import 'dart:io';

Future<void> checkIsEfi(setState) async {
  final String scriptOutput =
      await Process.run("/opt/jade_gui/scripts/checkEfi.sh", [])
          .then((ProcessResult result) {
    return result.stdout;
  });
  bool isEfi = scriptOutput == "UEFI" ? false : true;
  debugPrint(isEfi.toString());
  debugPrint(scriptOutput);
  setState(isEfi);
}

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Jadegui(),
      ),
    );

class Jadegui extends StatefulWidget {
  const Jadegui({Key? key}) : super(key: key);

  @override
  _JadeguiState createState() => _JadeguiState();
}

class _JadeguiState extends State<Jadegui> {
  int _selectedIndex = 0;
  bool nextpage = false;
  bool choseLayout = false;
  bool enableSudo = false;
  bool enableRoot = false;
  bool isEfi = false;
  bool ipv6 = false;
  bool enableTimeshift = true;
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

    switch (_selectedIndex) {
      case 0:
        widget = welcome(() {
          setState(() {
            _selectedIndex = _selectedIndex + 1;
          });
        });
        break;
      case 1:
        widget = locale(() {
          setState(() {
            _selectedIndex = _selectedIndex + 1;
          });
        }, () {
          setState(() {
            nextpage = true;
          });
        }, (region) {
          if (region != "") {
            setState(() {
              nextpage = false;
            });
          } else {
            setState(() {
              nextpage = true;
            });
          }
        }, nextpage);
        break;
      case 2:
        widget = keyboard(
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
        );
        break;
      case 3:
        widget = users(
          (value) {
            setState(() {
              enableSudo = value;
            });
          },
          enableSudo,
          (String? value) {
            setState(() {
              if (value != null) {
                password = value;
              }
            });
          },
          (value) {
            setState(() {
              confirmPassword = value;
            });
          },
          password,
          confirmPassword,
          (value) {
            setState(() {
              username = value;
            });
          },
          username,
          (value) {
            setState(() {
              enableRoot = value;
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
        );
        break;
      case 4:
        widget = desktopView(
          currDesktop,
          (selectedDesktop) {
            setState(() {
              currDesktop = selectedDesktop;
            });
          },
          () {
            setState(() {
              _selectedIndex = _selectedIndex + 1;
            });
          },
        );
        break;
      case 5:
        widget = misc(
          (value) {
            setState(() {
              ipv6 = value;
            });
          },
          (value) {
            setState(() {
              hostname = value;
            });
          },
          (value) {
            setState(() {
              enableTimeshift = value;
            });
          },
          ipv6,
          hostname,
          enableTimeshift,
          () {
            setState(() {
              _selectedIndex = _selectedIndex + 1;
            });
          },
        );
        break;
      case 6:
        widget = partitioning(
          disks,
          (value) {
            setState(() {
              disks = value;
            });
          },
          (value) {
            setState(() {
              selectedDisk = value;
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
            });
          },
          selectedDisk,
          partitionInfo,
        );
        break;
      case 7:
        checkIsEfi((value) {
          setState(() {
            isEfi = value;
          });
        });
        widget = summary(
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
            });
          },
          () {
            setState(() {
              _selectedIndex = _selectedIndex + 1;
            });
          },
        );
        break;
      case 8:
        widget = install(
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
              output = output + "\n" + value;
            });
          },
          output,
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

  void selectlocation(region) {}
}
