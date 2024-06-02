import 'package:bargainbites/features/authentication/screens/user/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
}

/// Variable
final deviceStorage = GetStorage();

/// Called from main.dart on app launch
@override
void onReady() {
  /// Here, out home screen will be replaced by the native screen
  // FlutterNativeSplash.remove();
  /// Redirect to the appropriate screen
  screenRedirect();
}

/// Function to show Relevant screen
screenRedirect() async {
  // Local Storage
  deviceStorage.writeIfNull('isFirstTime', true);

  // This condn check if it is the first time of the user then direct to onBoarding else direct to login,
  // but in our case we dont have an onboarding screen so direct to login everytime.
  deviceStorage.read('isFirstTime') != true
      ? Get.offAll(() => Login()) // Redirect to login screen if not first time
      : Get.offAll(() => Login()); // Redirect to a different screen if first time
}


/*--------------------------------- Email & Password sign-in -------------------------------*/

/// [EmailAuthentication] - LOGIN
//   Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
//     try{
//       return await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e){
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e){
//       throw TFirebaseAuthException(e.code).message;
//     } on FormatException catch(_){
//       throw const TFormatException();
//     } on PlatformException catch (e){
//       throw TPlatformException(e.code).message;
//     } catch (e){
//       throw 'Something went wrong. Please try again';
//     }
//   }
