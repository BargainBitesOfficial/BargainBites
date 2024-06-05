import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/auth_page.dart';
import 'features/authentication/controllers/user/signup_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupController()),
      ],
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bargain Bites',
        themeMode: ThemeMode.system,
        theme: ThemeData(
            textTheme: const TextTheme(
                titleMedium: TextStyle(fontFamily: 'Poppins')
            )
        ),
        // darkTheme: TAppTheme.darkTheme,
        home: const AuthPage(),
      ),
    );
  }
}