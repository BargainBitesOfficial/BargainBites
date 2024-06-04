import 'package:bargainbites/features/authentication/screens/verification_screen.dart';
import 'package:bargainbites/features/startup/screens/splash_screen.dart';
import 'package:bargainbites/features/startup/screens/onboarding_customer.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/utils/theme/theme.dart';
import 'package:provider/provider.dart';

import 'features/authentication/auth_page.dart';
import 'features/authentication/controllers/user/signup_controller.dart';
import 'features/authentication/screens/user/signup.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bargain Bites',
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        // darkTheme: TAppTheme.darkTheme,
        home: const UserSignupScreen(),
      ),
    );
  }
}
