import 'package:flutter/material.dart';
import 'Region.dart';
import 'location.dart';

Widget locale(next, nextPage, selectlocation, isnextpage, Europe) {
  Widget widget;
  selectlocation(getSelectedRegion());
  String selectedregion = getSelectedRegion();
  if (isnextpage == false) {
    widget = region(nextPage);
  } else {
    widget = location(selectedregion, Europe);
  }
  return widget;
}
