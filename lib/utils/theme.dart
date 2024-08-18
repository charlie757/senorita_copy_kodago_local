import 'package:flutter/material.dart';
import 'stringConstants.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kContentColorLightTheme,
    scaffoldBackgroundColor: kContentColorDarkTheme,
    appBarTheme: appBarTheme,
    // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme.apply(bodyColor: kContentColorLightTheme, displayColor: kContentColorLightTheme)),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kContentColorDarkTheme,
    scaffoldBackgroundColor: kContentColorLightTheme,
    appBarTheme: appBarTheme,
    // textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme.apply(bodyColor: kContentColorDarkTheme, displayColor: kContentColorDarkTheme))
  );
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
