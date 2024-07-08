import 'dart:math';

import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:bargainbites/features/order/screens/product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';

import 'package:bargainbites/features/authentication/models/merchant_model.dart';
import 'package:bargainbites/features/homepage/controllers/explore_controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ExploreController _exploreController = ExploreController();
  final ProductController _productController = ProductController();
  List<MerchantModel> merchants = [];
  List<ListingItemModel> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMerchants();
    _fetchProducts();
  }

  Map<String, double> merchantDistances = {};

  Future<void> _fetchMerchants() async {
    List<MerchantModel> fetchedMerchants =
        await _exploreController.fetchMerchants();

    // calculating the distance of merchants with current location
    for (MerchantModel merchant in fetchedMerchants) {
      //double distance = await _exploreController.getDistanceByRoad("N9B 2K9", merchant.postalCode, "");
      //merchant.currDistance = (distance != -1.0) ? distance : -1;

      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      // merchant.merchantRating = double.parse((3.0 + (5.0 - 3.0) * random.nextDouble()).toStringAsFixed(1));

      // Store the distance in the map
      merchantDistances[merchant.merchantId] = merchant.currDistance;
    }

    // Sort merchants by distance
    fetchedMerchants.sort((a, b) => a.currDistance.compareTo(b.currDistance));

    setState(() {
      merchants = fetchedMerchants;
      isLoading = false;
    });
  }

  Future<void> _fetchProducts() async {
    List<ListingItemModel> fetchedProducts =
        await _productController.fetchProducts();

    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: TColors.linerGradient,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(children: [
                            Text(
                              'Discover Savings',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 22,
                                  color: TColors.bWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    color: TColors.bWhite,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: IconButton(
                                    icon: const Icon(Icons.notifications),
                                    color: TColors.primary,
                                    // Match the background gradient
                                    onPressed: () {
                                      // Add your onPressed code here!
                                    },
                                  )))
                            ],
                          ),
                        ]),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('University Avenue',
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    color: Colors.white)),
                          ]),
                          Text('within 10 km',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 10,
                                  color: Colors.white)),
                        ]),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: 45,
                                child: TextField(
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,
                                            color: Colors.black54),
                                        filled: true,
                                        fillColor: TColors.bWhite,
                                        hintText:
                                            'Search the best discounts...',
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))))),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "What’s in the neighborhood"),
            HorizontalItemList(items: products),
            const SectionTitle(title: "Stores"),
            HorizontalItemListForStores(items: merchants),
            const SectionTitle(title: "Explore"),
            const VerticalItemList(),
          ],
        )));
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //         const ForgotPassword()));
            },
            child: const Text(
              "see all",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalItemList extends StatelessWidget {
  final List<ListingItemModel> items;

  const HorizontalItemList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205.0,
      child: FutureBuilder<Map<String, String>>(
        future: _fetchMerchantNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          final merchantNames = snapshot.data ?? {};

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              final merchantName =
                  merchantNames[product.merchantId] ?? 'Unknown Merchant';

              return DiscountCard(
                product: product,
                merchantName: merchantName,
              );
            },
          );
        },
      ),
    );
  }

  Future<Map<String, String>> _fetchMerchantNames() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, String> merchantNames = {};

    try {
      List<String> merchantIds =
          items.map((item) => item.merchantId).toSet().toList();

      for (String merchantId in merchantIds) {
        DocumentSnapshot doc =
            await firestore.collection('Merchants').doc(merchantId).get();

        if (doc.exists) {
          merchantNames[merchantId] = doc['merchantName'] ?? 'Unknown Merchant';
        } else {
          merchantNames[merchantId] = 'Unknown Merchant';
        }
      }

      return merchantNames;
    } catch (e) {
      print('Error fetching merchant names: $e');
      return {};
    }
  }
}

class HorizontalItemListForStores extends StatelessWidget {
  final List<MerchantModel> items;

  const HorizontalItemListForStores({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return DiscountCardForStores(merchant: items[index]);
        },
      ),
    );
  }
}

class VerticalItemList extends StatelessWidget {
  const VerticalItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) => const DiscountCardVertical()),
    );
  }
}

class DiscountCard extends StatelessWidget {
  final ListingItemModel product;
  final String merchantName;

  const DiscountCard(
      {super.key, required this.product, required this.merchantName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        child: Container(
          width: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/grocery.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 110.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                merchantName,
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              Row(
                children: [
                  const Icon(Icons.attach_money_sharp, size: 16.0),
                  Text(
                    '${product.price}',
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                  Text(
                    '10 Km',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountCardForStores extends StatelessWidget {
  final MerchantModel merchant;

  const DiscountCardForStores({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/grocery.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                  ),
                ),
                // Positioned(
                //   top: 8.0,
                //   right: 8.0,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8.0)),
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 4.0, vertical: 2.0),
                //     // child: const Text(
                //     //   'new',
                //     //   style: TextStyle(
                //     //       color: TColors.primary,
                //     //       fontSize: 12.0,
                //     //       fontFamily: "Poppins"),
                //     // ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              merchant.merchantName,
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
            Text(merchant.streetAddress,
                style: const TextStyle(fontFamily: "Poppins")),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                Text('${merchant.currDistance} km',
                    style: const TextStyle(fontFamily: "Poppins")),
              ],
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class DiscountCardVertical extends StatelessWidget {
  const DiscountCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/grocery.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: const Text(
                      'new',
                      style: TextStyle(
                          color: TColors.primary,
                          fontSize: 12.0,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Subway',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
            const Text('Closes at 10 PM',
                style: TextStyle(fontFamily: "Poppins")),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16.0),
                Text('4.7', style: TextStyle(fontFamily: "Poppins")),
                SizedBox(width: 4.0),
                Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                Text('10 km', style: TextStyle(fontFamily: "Poppins")),
              ],
            ),
            const SizedBox(height: 8.0),
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   color: Colors.green[100],
            //   child: const Text(
            //     '50% OFF',
            //     style: TextStyle(
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
