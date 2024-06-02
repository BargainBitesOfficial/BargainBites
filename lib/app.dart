import 'package:flutter/material.dart';
import 'package:bargainbites/utils/theme/theme.dart';

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