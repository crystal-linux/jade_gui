import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';

class installPrefs {
  final Location locale;
  final String keymap;
  final String layout;
  final String username;
  final bool enableSudo;
  final bool enableRoot;
  final Desktop desktop;
  final String disk;

  installPrefs({
    this.locale = const Location(),
    this.keymap = "",
    this.layout = "",
    this.username = "",
    this.enableSudo = false,
    this.enableRoot = false,
    this.desktop = const Desktop(),
    this.disk = "",
  });

  /* Map toJson() => {

  }*/
}
