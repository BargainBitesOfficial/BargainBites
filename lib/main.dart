import 'package:bargainbites/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

void main() async {

  /// Widgets binding
      WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
      await GetStorage.init();

  /// Await Splash until other items load
  //     FlutterNativeSplash.preserve(WidgetsBinding: widgetsBinding);

  /// Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  runApp(const App());
}