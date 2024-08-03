import 'package:bargainbites/features/homepage/screens/merchant_store_hours.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/text_styles.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';

class MerchantProfilePage extends StatefulWidget {
  const MerchantProfilePage({super.key});

  @override
  State<MerchantProfilePage> createState() => _MerchantProfilePageState();
}

class _MerchantProfilePageState extends State<MerchantProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isLoading = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const UserType()));
  }

  @override
  void initState() {
    super.initState();
    fetchMerchantNameByEmail(user.email!);
  }

  // var merchant;
  String merchantName = "", merchantId = "";

  Future<void> fetchMerchantNameByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Merchants')
          .where('merchantEmail', isEqualTo: email)
          .limit(1) // Limit to one document
          .get();

      if (snapshot.docs.isNotEmpty) {
        var merchantDoc = snapshot.docs.first;
        setState(() {
          merchantName = merchantDoc['storeName'];
          merchantId = merchantDoc['merchantID'];
          isLoading = false;
        });
      } else {
        setState(() {
          merchantName = "Merchant not found";
          merchantId = "Merchant not found";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        merchantName = "Error fetching merchant: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // fetchMerchantName();
    return Scaffold(
      backgroundColor: TColors.bWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColors.primaryBtn,
        toolbarHeight: 150, // Set a more reasonable height for the app bar
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [TColors.primaryBtn, TColors.primaryBtn],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                merchantName,
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: Text(
                'Account settings',
                style: TextStyles.regulartext(),
              ),
              subtitle: Text(
                'Change personal information',
                style: TextStyles.regulartext(color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Implement navigation to account settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Colors.black),
              title: Text(
                'Edit Store Info',
                style: TextStyles.regulartext(),
              ),
              subtitle: Text(
                'Change Store details',
                style: TextStyles.regulartext(color: Colors.grey),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StoreHoursPage(merchantId: merchantId, merchantName: merchantName)));
                // Implement navigation to edit store info
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.notifications, color: Colors.black),
            //   title: Text(
            //     'Notifications',
            //     style: TextStyles.regulartext(),
            //   ),
            //   subtitle: Text(
            //     'Get all your updates here',
            //     style: TextStyles.regulartext(color: Colors.grey),
            //   ),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () {
            //     // Implement navigation to notifications
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.credit_card, color: Colors.black),
            //   title: Text(
            //     'Payment Methods',
            //     style: TextStyles.regulartext(),
            //   ),
            //   subtitle: Text(
            //     'Cards',
            //     style: TextStyles.regulartext(color: Colors.grey),
            //   ),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () {
            //     // Implement navigation to payment methods
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.star, color: Colors.black),
            //   title: Text(
            //     'Rate our App',
            //     style: TextStyles.regulartext(),
            //   ),
            //   subtitle: Text(
            //     'Help us get 5 stars',
            //     style: TextStyles.regulartext(color: Colors.grey),
            //   ),
            //   trailing: const Icon(Icons.chevron_right),
            //   onTap: () {
            //     // Implement navigation to rate app
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: Text(
                'Sign Out',
                style: TextStyles.regulartext(),
              ),
              onTap: () {
                signUserOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
