import 'package:bargainbites/features/authentication/auth_page.dart';
import 'package:bargainbites/features/authentication/controllers/merchant/merchant_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/controllers/user/signup_controller.dart';


void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return
         MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=> SignupController()),
            ChangeNotifierProvider(create: (_) => MerchantSignupController()
    )],
           child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bargain Bites',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      home: const AuthPage(),
    ));
    // );
  }
}
