import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
      primaryColor: Colors.purpleAccent, brightness: Brightness.light);

  static final dark =
      ThemeData(primaryColor: Colors.black, brightness: Brightness.dark);

  TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey));
  }

  TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black));
  }
}
