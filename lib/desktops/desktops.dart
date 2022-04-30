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
    imageurl: 'assets/crystal-logo-minimal.png',
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
    imageurl: 'assets/desktops/gnome.png',
  ),
  Desktop(
    name: "Kde",
    displayManager: "sddm",
    packages: [
      "plasma",
      "xorg",
      "kde-applications",
      "sddm",
    ],
    imageurl: 'assets/desktops/kde.png',
  ),
  Desktop(
    name: "Budgie",
    displayManager: "lightdm",
    packages: [
      "budgie-desktop",
      "xorg",
      "gnome",
    ],
    imageurl: "assets/desktops/budgie.png",
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
    imageurl: "assets/desktops/mate.png",
  ),
  Desktop(
    name: "Enlightenment",
    displayManager: "",
    packages: [
      "enlightenment",
      "terminology",
    ],
    imageurl: "assets/desktops/enlightenment.png",
  ),
  Desktop(
    name: "Xfce",
    displayManager: "lightdm",
    packages: [
      "xfce4",
      "xfce4-goodies",
    ],
    imageurl: "assets/desktops/xfce.png",
  ),
  Desktop(
    name: "None/DIY",
    displayManager: "",
    packages: [],
  ),
];
