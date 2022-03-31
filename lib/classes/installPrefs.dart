import 'package:jade_gui/Locales/locales.dart';
import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';

class installPrefs {
  final Location locale;
  final String keymap;
  final String layout;
  final String username;
  final String password;
  final bool enableSudo;
  final String rootPass;
  final Desktop desktop;
  final String disk;
  final bool isEfi;
  final String bootloader;
  final String bootloaderLocation;
  final String hostname;
  final bool ipv6;
  final bool enableTimeshift;

  installPrefs({
    this.locale = const Location(),
    this.keymap = "",
    this.layout = "",
    this.username = "",
    this.password = "",
    this.enableSudo = false,
    this.rootPass = "",
    this.desktop = const Desktop(),
    this.disk = "",
    this.isEfi = false,
    this.bootloader = "",
    this.bootloaderLocation = "",
    this.hostname = "",
    this.ipv6 = false,
    this.enableTimeshift = false,
  });

  Map toJson() => {
        "partition": {
          "device": disk,
          "mode": "auto",
          "efi": isEfi,
        },
        "bootloader": {
          "type": bootloader,
          "location": bootloaderLocation,
        },
        "locale": {
          "locale": [
            locale.locale,
          ],
          "keymap": keymap,
          "timezone": locale.region,
        },
        "networking": {
          "hostname": hostname,
          "ipv6": ipv6,
        },
        "users": [
          {
            "name": username,
            "password": password,
            "hasroot": enableSudo,
          }
        ],
        "rootpass": rootPass,
        "desktop": desktop.name,
        "timeshift": enableTimeshift,
        "extra_packages": [
          "firefox",
        ]
      };
}
