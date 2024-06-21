import 'package:flutter/material.dart';

class TColors {
  TColors._();

  // app basic colors
  static const Color primary = Color(0xFF059471);// primary color
  static const Color secondary = Color(0xFF4B68FF); // example color
  static const Color accent = Color(0xFF4B68FF); // example color

  // general colors
  static const Color bBlack = Colors.black;
  static const Color bWhite = Colors.white;
  static const Color bRed = Colors.red;
  static const Color bGreen = Colors.green;
  static const Color bBlue = Colors.blue;
  static const Color bYellow = Colors.yellow;
  static const Color bOrange = Colors.orange;
  static const Color bPink = Colors.pink;
  static const Color bPurple = Colors.purple;
  static const Color bBrown = Colors.brown;
  static const Color bGrey = Colors.grey;
  static const Color bIndigo = Colors.indigo;
  static const Color bCyan = Colors.cyan;
  static const Color bLime = Colors.lime;
  static const Color bTeal = Colors.teal;
  static const Color bAmber = Colors.amber;
  static const Color bDeepOrange = Colors.deepOrange;
  static const Color bLightBlue = Colors.lightBlue;
  static const Color bLightGreen = Colors.lightGreen;
  static const Color bDeepPurple = Colors.deepPurple;
  static const Color bBlueGrey = Colors.blueGrey;


  // Gradient Colors
  static const Gradient linerGradient = LinearGradient(
    colors: [Color(0xFF01CA7E), Color(0xFF01AB6B), Color(0xFF00643E),],
    stops: [0.021, 0.2461, 0.979],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  // text colors
  static const Color greyText = Color(0xFF757373);// primary color
  static const Color primaryText = Color(0xFF059471);// primary color
  static const Color starIconColor = Color(0xFFE3C745);// primary color


  // Background Colors

  // Background Container Colors
  static const Color backgroundContainerColor = Color(0xFFE8E8E8);

  // Button Colors
  static const Color primaryBtn = Color(0xFF059471);// primary color


  // Border Colors

  // Error and Validation Colors
  static const Color primaryErr = Color(0xFFF54135);// primary color


  // Neutral Shades
}