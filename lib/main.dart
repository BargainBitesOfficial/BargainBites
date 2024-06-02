import 'package:bargainbites/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {

  // Todo: Add widgets binding
  // Todo: Init Local Storage
  // TOdo: Await Native Splash
  // Todo: Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
          (FirebaseApp value) => Get.put(AuthentiationRepository()),
  );
  // Todo: Initialize Authentication


  runApp(const App());
}