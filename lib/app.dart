import 'package:bargainbites/features/authentication/screens/user/order_screen.dart';
import 'package:bargainbites/features/homepage/screens/explore.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/controllers/user/signup_controller.dart';
import 'features/authentication/controllers/merchant/merchant_signup_controller.dart';
import 'features/homepage/screens/homepage.dart';// Assuming you have a Profile screen

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    ExplorePage(),
    OrderScreen(),
    UserType()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => MerchantSignupController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bargain Bites',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        home: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: TColors.primary,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
