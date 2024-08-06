import 'package:flutter/material.dart';

import '../../core/constants.dart';



class Themes {
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    iconTheme: const IconThemeData(color: Kcolor),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
    ),
  );

  static ThemeData customLightTheme = ThemeData.light().copyWith(
    iconTheme: const IconThemeData(color: Colors.grey),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
    ),

  );
}
