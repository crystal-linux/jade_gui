import 'package:flutter/material.dart';
import 'functions/welcome.dart';
import 'functions/locale.dart';
import 'classes/location.dart';
import 'Locales/locales.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: jadegui(),
      ),
    );

class jadegui extends StatefulWidget {
  const jadegui({Key? key}) : super(key: key);

  @override
  _jadeguiState createState() => _jadeguiState();
}

class _jadeguiState extends State<jadegui> {
  int _selectedIndex = 0;
  bool nextpage = false;
  void nextslide() {
    setState(() {
      _selectedIndex = _selectedIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 17, 17, 17),
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: Color.fromARGB(0, 27, 27, 27),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.desktop_windows_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                selectedIcon: Icon(
                  Icons.desktop_windows_outlined,
                  color: Color.fromARGB(255, 169, 0, 255),
                ),
                label: Text(
                  'Desktop',
                  style: TextStyle(
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
                      color: Color.fromARGB(255, 169, 0, 255),
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
        }, nextpage, europe);
        break;
      case 2:
        widget = const Text(
          'Showing Keymap screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 3:
        widget = const Text(
          'Showing Timezone screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 4:
        widget = const Text(
          'Showing Users screen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 169, 0, 255),
          ),
        );
        break;
      case 5:
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
