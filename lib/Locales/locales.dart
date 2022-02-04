import 'Africa.dart';
import 'America.dart';
import 'Antarctica.dart';
import 'Asia.dart';
import 'Atlantic.dart';
import 'Australia.dart';
import 'Brazil.dart';
import 'Canada.dart';
import 'Chile.dart';
import 'Europe.dart';
import 'Indian.dart';
import 'Mexico.dart';
import 'Pacific.dart';
import 'US.dart';
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
