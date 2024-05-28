
import 'package:flutter/cupertino.dart';

class TDeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // add other utils here.. (11:26)
}