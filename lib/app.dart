import 'package:bargainbites/features/authentication/screens/verification_screen.dart';
import 'package:bargainbites/features/startup/screens/splash_screen.dart';
import 'package:bargainbites/features/startup/screens/onboarding_customer.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/utils/theme/theme.dart';

import 'features/authentication/auth_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bargain Bites',
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      // initialBinding: general_bindings(),
      home: const AuthPage(),
    );
  }
}