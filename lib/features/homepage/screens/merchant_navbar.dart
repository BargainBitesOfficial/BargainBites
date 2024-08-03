import 'package:bargainbites/features/homepage/screens/merchant_active_product_screen.dart';
import 'package:bargainbites/features/homepage/screens/merchant_catalogue.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';

import 'merchant_profile_page.dart';

class MerchantNavbar extends StatefulWidget {
  const MerchantNavbar({super.key});

  @override
  State<MerchantNavbar> createState() => _MerchantNavbarState();
}

class _MerchantNavbarState extends State<MerchantNavbar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const ActiveProductsPage(),
    const MerchantCatalogue(),
    const MerchantProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt_sharp),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize_sharp),
            label: 'Catalogue',
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
    );
  }
}
