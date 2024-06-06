import 'package:flutter/material.dart';

class TextStyles {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;


  static TextStyle lighttext({Color color = Colors.black}) => TextStyle(
    fontSize: 14,
    fontWeight: light,
    color: color,
  );
  static TextStyle regulartext({Color color = Colors.black}) => TextStyle(
    fontSize: 16,
    fontWeight: regular,
    color: color,
  );

  static TextStyle button({Color color = Colors.white}) => TextStyle(
    fontSize: 18,
    fontWeight: bold,
    color: color,
  );

  static TextStyle name({Color color = Colors.black}) => TextStyle(
    fontSize: 20,
    fontWeight: bold,
    color: color,
  );

  static TextStyle heading({Color color = Colors.black}) => TextStyle(
    fontSize: 24,
    fontWeight: bold,
    color: color,
  );

}
