import 'africa.dart';
import 'america.dart';
import 'antarctica.dart';
import 'asia.dart';
import 'atlantic.dart';
import 'australia.dart';
import 'brazil.dart';
import 'canada.dart';
import 'chile.dart';
import 'europe.dart';
import 'indian.dart';
import 'mexico.dart';
import 'pacific.dart';
import 'us.dart';
import 'package:jade_gui/classes/location.dart';

class Local {
  List<Location> location = [Location()];
  String name = "";

  Local(this.location, this.name);
}

List<Local> locations = [
  Local(africa, "Africa"),
  Local(america, "America"),
  Local(antarctica, "Antarctica"),
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
