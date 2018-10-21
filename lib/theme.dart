import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ThemeColors {
  static Color primaryColor = Pigment.fromString("#0072CE");
  static Color accentColor = Pigment.fromString("#1D4F91");

  static Color textColor = Colors.black87;

  static Color background = Pigment.fromString("#FAF9FA");
  static Color backgroundAlt = Pigment.fromString("#DFD1A7");
}

ThemeData getTheme() {
  return ThemeData(
      fontFamily: "WorkSans",
      primaryColor: ThemeColors.primaryColor,
      accentColor: ThemeColors.accentColor,
      textTheme: getTextTheme(),
    );
}

TextTheme getTextTheme() {
  final defaultTheme = ThemeData.light().textTheme;

  return defaultTheme.copyWith(
      title: defaultTheme.title.copyWith(color: ThemeColors.textColor, fontSize: 18.0, fontWeight: FontWeight.w500),
  );
}
