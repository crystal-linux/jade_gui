import 'package:jade_gui/classes/desktop.dart';

List<Desktop> desktops = const [
  Desktop(
    name: "Onyx",
    displayManager: "lightdm",
    packages: [
      "onyx",
      "xorg-server",
      "budgie-desktop",
      "gnome",
    ],
    imageurl: 'assets/jade_logo.png',
  ),
  Desktop(
    name: "Gnome",
    displayManager: "gdm",
    packages: [
      "gnome",
      "xorg",
      "gnome-extra",
      "chrome-gnome-shell",
    ],
    //imageurl: '',
  ),
  Desktop(
    name: "KDE plasma",
    displayManager: "sddm",
    packages: [
      "plasma",
      "xorg",
      "kde-applications",
      "sddm",
    ],
  ),
  Desktop(
    name: "Budgie",
    displayManager: "lightdm",
    packages: [
      "budgie-desktop",
      "xorg",
      "gnome",
    ],
    //imageurl: "",
  ),
  Desktop(
    name: "Mate",
    displayManager: "lightdm",
    packages: [
      "mate",
      "mate-extra",
      "mate-applet-dock",
      "mate-applet-streamer",
      "xorg",
      "mate-extra",
      "mate-desktop",
    ],
    //imageurl: "",
  ),
  Desktop(
    name: "Enlightenment",
    displayManager: "",
    packages: [
      "enlightenment",
      "terminology",
    ],
    //imageurl: "",
  ),
  Desktop(
    name: "XFCE",
    displayManager: "lightdm",
    packages: [
      "xfce4",
      "xfce4-goodies",
    ],
    //imageurl: "",
  ),
  Desktop(
    name: "None/DIY",
    displayManager: "",
    packages: [],
    //imageurl: "",
  ),
];
