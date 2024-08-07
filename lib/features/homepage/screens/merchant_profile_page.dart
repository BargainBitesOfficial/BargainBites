import 'package:bargainbites/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';

import 'package:bargainbites/utils/constants/text_styles.dart';
import 'merchant_store_hours.dart';

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
    fetchMerchantDetailsByEmail(user.email!);
  }

  String merchantName = "", merchantId = "", merchantImageUrl = "";

  Future<void> fetchMerchantDetailsByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Merchants')
          .where('merchantEmail', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var merchantDoc = snapshot.docs.first;
        String gsImageUrl =
            merchantDoc['imageUrl']; // Assuming this is the gs:// URL
        String httpImageUrl = await getDownloadURL(gsImageUrl);

        setState(() {
          merchantName = merchantDoc['storeName'];
          merchantId = merchantDoc['merchantID'];
          merchantImageUrl = httpImageUrl;
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

  Future<String> getDownloadURL(String gsUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 150,
        flexibleSpace: merchantImageUrl.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                image: NetworkImage(merchantImageUrl),
                fit: BoxFit.cover,
              )))
            : Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [TColors.primaryBtn, TColors.primaryBtn],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 30.0),
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
                        color: Colors.black,
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
            const SizedBox(height: 10),
            Text(
              merchantName,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreHoursPage(
                      merchantId: merchantId,
                      merchantName: merchantName,
                    ),
                  ),
                );
              },
            ),
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
