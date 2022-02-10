import 'package:flutter/material.dart';
import 'package:jade_gui/functions/location/location.dart';
import 'package:jade_gui/functions/welcome.dart';
import 'package:jade_gui/functions/locale.dart';
import 'package:jade_gui/functions/keyboard.dart';
import 'package:jade_gui/functions/users.dart';
import 'package:jade_gui/functions/desktop.dart';
import 'package:jade_gui/classes/keymap.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/desktops/desktops.dart';

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
  Keymap chosenLayout = Keymap();
  bool enableSudo = false;
  bool enableRoot = false;
  String password = "";
  String confirmPassword = "";
  String username = "";
  String rootPass = "";
  String confirmRootPass = "";
  Desktop currDesktop = desktops[0];
  void nextslide() {
    setState(() {
      _selectedIndex = _selectedIndex + 1;
    });
  }

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
          )
        ],
      ),
    );
  }

  bool loadnextpage(region) {
    bool next = false;
    print("here");
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
    // other logic
    // Declare a widget variable,
    // it will be assigned later according
    // to the condition
    Widget widget;

    // Using switch statement to display desired
    // widget if any certain condition is met
    // You are free to use any condition
    // For simplicity I have used boolean contition
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
        print(
            "${getSelectedLocPack().region}/${getSelectedLocPack().location}");
        print(getSelectedLocPack().locale);
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
        print("${getChosenLayout()} - ${getChosenVariant()}");
        widget = users(
          (value) {
            setState(() {
              enableSudo = value;
            });
          },
          enableSudo,
          (String? value) {
            setState(() {
              debugPrint(value);
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
              debugPrint(value);
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
        print("Username: $username");
        print("Password: $password");
        print("Confirm Password: $confirmPassword");
        print("Enable Root: $enableSudo");
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
        print("Desktop: ${currDesktop.name}");
        widget = const Text(
          'Showing Desktop screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 6:
        widget = const Text(
          'Showing Misc screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 7:
        widget = const Text(
          'Showing Partitioning screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 8:
        widget = const Text(
          'Showing Summary screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 9:
        widget = const Text(
          'Showing Installing screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      default:
        widget = const Text(
          'You should not see this, report this at git.tar.black/crystal/jade_gui',
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
