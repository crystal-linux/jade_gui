import 'package:flutter/material.dart';
import 'package:jade_gui/functions/location/region.dart';
import 'package:jade_gui/functions/location/location.dart';
import 'package:jade_gui/locales/locales.dart';

Widget locale(next, nextPage, selectlocation, isnextpage, writeToLog) {
  Widget widget;
  selectlocation(getSelectedRegion());
  String selectedregion = getSelectedRegion();
  if (isnextpage == false) {
    widget = region(nextPage, locations);
  } else {
    widget = location(selectedregion, next);
  }
  return widget;
}
