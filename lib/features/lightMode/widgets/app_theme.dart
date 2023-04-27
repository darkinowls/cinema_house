import 'package:flutter/material.dart';

final Map<bool, ThemeData> appThemes = {
  false: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      splashColor: Colors.green,
      indicatorColor: Colors.green,
      accentColor: Colors.green,
      // cardColor: Colors.green,
      focusColor: Colors.white),
  true: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      indicatorColor: Colors.green,
      accentColor: Colors.green,
      focusColor: Colors.black),
};
