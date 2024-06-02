import 'package:flutter/material.dart';

class TColors {
  TColors._(); // in Dart for creating constructors we need to put '.' followed by a name but in this case the name is private '_' and
  // therefore it is considered as private constructor. In dart '_' is used for private.

  // app basic colors
  static const Color primary = Color(0xFF31CB0D); // example color
  static const Color secondary = Color(0xFF0FCC00); // example color
  static const Color accent = Color(0xFF187200); // example color

  // Gradient Colors
  static const Gradient linerGradient = LinearGradient(  // example
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );

  // text colors

  // Background Colors

  // Background Container Colors

  // Button Colors
  static const Color buttonPrimary = Color(0xFF059471); // example color

  // Border Colors

  // Error and Validation Colors

  // Neutral Shades
}