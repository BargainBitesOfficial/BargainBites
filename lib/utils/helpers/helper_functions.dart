import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {

  // get specific color by name
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  // add other required helper functions here.
}