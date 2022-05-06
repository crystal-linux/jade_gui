import 'package:jade_gui/classes/desktop.dart';
import 'package:jade_gui/classes/location.dart';

class InstallPrefs {
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
  final bool enableFlatpak;
  final bool manualPartitioning;
  final List<String> partitions;

  InstallPrefs({
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
    this.enableFlatpak = false,
    this.manualPartitioning = false,
    this.partitions = const [],
  });

  Map toJson() => {
        "partition": {
          "device": disk,
          "mode": manualPartitioning ? "Manual" : "Auto",
          "efi": isEfi,
          "partitions": partitions,
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
        "flatpak": enableFlatpak,
        "extra_packages": [
          "firefox",
        ]
      };
}
