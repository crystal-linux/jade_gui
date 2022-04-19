import 'package:jade_gui/locales/arctic.dart';
import 'package:jade_gui/locales/africa.dart';
import 'package:jade_gui/locales/america.dart';
import 'package:jade_gui/locales/antarctica.dart';
import 'package:jade_gui/locales/asia.dart';
import 'package:jade_gui/locales/atlantic.dart';
import 'package:jade_gui/locales/australia.dart';
import 'package:jade_gui/locales/brazil.dart';
import 'package:jade_gui/locales/canada.dart';
import 'package:jade_gui/locales/chile.dart';
import 'package:jade_gui/locales/europe.dart';
import 'package:jade_gui/locales/indian.dart';
import 'package:jade_gui/locales/mexico.dart';
import 'package:jade_gui/locales/pacific.dart';
import 'package:jade_gui/locales/us.dart';
import 'package:jade_gui/classes/location.dart';

class Local {
  List<Location> location = const [Location()];
  String name = "";

  Local(this.location, this.name);
}

List<Local> locations = [
  Local(africa, "Africa"),
  Local(america, "America"),
  Local(antarctica, "Antarctica"),
  Local(arctic, "Arctic"),
  Local(asia, "Asia"),
  Local(atlantic, "Atlantic"),
  Local(australia, "Australia"),
  Local(brazil, "Brazil"),
  Local(canada, "Canada"),
  Local(chile, "Chile"),
  Local(europe, "Europe"),
  Local(indian, "Indian"),
  Local(mexico, "Mexico"),
  Local(pacific, "Pacific"),
  Local(us, "US"),
];
