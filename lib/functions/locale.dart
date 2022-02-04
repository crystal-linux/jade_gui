import 'package:flutter/material.dart';
import 'Region.dart';
import 'location.dart';
import 'package:jade_gui/Locales/locales.dart';

Widget locale(next, nextPage, selectlocation, isnextpage) {
  Widget widget;
  selectlocation(getSelectedRegion());
  String selectedregion = getSelectedRegion();
  print(selectedregion);
  if (isnextpage == false) {
    widget = region(nextPage, locations);
  } else {
    widget = location(selectedregion, next);
  }
  return widget;
}
