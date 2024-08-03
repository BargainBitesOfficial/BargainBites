import 'package:bargainbites/features/authentication/auth_page.dart';
import 'package:flutter/material.dart';


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
        // return MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_) => SignupController()),
        //   ],
        //   child:
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
    );
    // );
  }
}
