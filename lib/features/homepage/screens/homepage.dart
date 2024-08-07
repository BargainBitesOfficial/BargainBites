import 'dart:math';

import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:bargainbites/features/homepage/screens/view_merchant_page.dart';
import 'package:bargainbites/features/order/screens/product_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  List<MerchantModel> filteredMerchants = [];
  List<ListingItemModel> products = [];
  List<ListingItemModel> filteredProducts = [];
  bool isLoading = true;
  bool noResultsFound = false;
  String postalCode = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMerchants();
    _fetchProducts();
    _fetchUserPostalCode();
    _searchController.addListener(_filterResults);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterResults);
    _searchController.dispose();
    super.dispose();
  }

  Map<String, double> merchantDistances = {};

  Future<void> _fetchMerchants() async {
    List<MerchantModel> fetchedMerchants =
        await _exploreController.fetchMerchants();
    for (MerchantModel merchant in fetchedMerchants) {
      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      merchantDistances[merchant.merchantID] = merchant.currDistance;
    }
    fetchedMerchants.sort((a, b) => a.currDistance.compareTo(b.currDistance));

    setState(() {
      merchants = fetchedMerchants;
      filteredMerchants = fetchedMerchants;
      isLoading = false;
    });
  }

  void _fetchUserPostalCode() async {
    String user = FirebaseAuth.instance.currentUser!.email!;
    var snapshot = (await FirebaseFirestore.instance
            .collection('Users')
            .where('email',
                isEqualTo: FirebaseAuth.instance.currentUser!.email!)
            .get())
        .docs
        .first;
    postalCode = snapshot['postalCode'];
  }

  Future<void> _fetchProducts() async {
    List<ListingItemModel> fetchedProducts =
        await _productController.fetchProducts();
    setState(() {
      products = fetchedProducts;
      filteredProducts = fetchedProducts;
      isLoading = false;
    });
  }

  void _filterResults() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
      } else {
        filteredMerchants = merchants.where((merchant) {
          return merchant.storeName.toLowerCase().contains(query);
        }).toList();

        filteredProducts = products.where((product) {
          return product.productName.toLowerCase().contains(query);
        }).toList();
      }
      noResultsFound = filteredMerchants.isEmpty && filteredProducts.isEmpty;
      if (filteredProducts.isEmpty || filteredProducts.length < 1) {
        filteredProducts = products;
      }
      if (filteredMerchants.isEmpty || filteredMerchants.length < 1) {
        filteredMerchants = merchants;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: TColors.linerGradient,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Text(
                        'Discover Savings',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                          color: TColors.bWhite,
                          fontWeight: FontWeight.w600,
                        ),
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
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(
                      CupertinoIcons.location_fill,
                      // Use any icon you prefer from the Icons class
                      color: TColors.bWhite, // Set the icon color
                      size: 14, // Set the icon size
                    ),
                    const SizedBox(width: 6),
                    Text(postalCode,
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.white))
                  ])
                ]),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.black54),
                            filled: true,
                            fillColor: TColors.bWhite,
                            hintText: 'Search the best discounts...',
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (noResultsFound)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No merchants or products found',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ),
                    ),
                  const SectionTitle(title: "What’s in the neighborhood"),
                  HorizontalItemList(items: filteredProducts),
                  const SectionTitle(title: "Stores"),
                  HorizontalItemListForStores(items: filteredMerchants),
                  const SectionTitle(title: "Explore"),
                  VerticalItemList(items: merchants),
                ],
              ),
            ),
    );
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
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalItemList extends StatelessWidget {
  final List<ListingItemModel> items;

  HorizontalItemList({Key? key, required this.items}) : super(key: key);

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
          merchantNames[merchantId] = doc['storeName'] ?? 'Unknown Merchant';
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
      height: 230.0,
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
  final List<MerchantModel> items;

  VerticalItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: (items.length < 5) ? items.length : 5,
        itemBuilder: (context, index) {
          return DiscountCardVertical(merchant: items[index]);
        },
      ),
    );
  }
}

class DiscountCard extends StatelessWidget {
  final ListingItemModel product;
  final String merchantName;

  DiscountCard({
    Key? key,
    required this.product,
    required this.merchantName,
  }) : super(key: key);

  Future<String> fetchImageUrl(String productId) async {
    var product = (await FirebaseFirestore.instance
            .collection('CatalogItems')
            .where('productID', isEqualTo: productId)
            .get())
        .docs
        .first;

    String productImage = product['itemImage'];
    return productImage;
  }

  Future<String> getDownloadURL(String gsUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product, cartModel: null),
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
                    child: FutureBuilder<String>(
                      future: fetchImageUrl(product.productId)
                          .then((productImage) => getDownloadURL(productImage)),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(child: Icon(Icons.error)),
                          );
                        } else if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(child: Icon(Icons.image)),
                          );
                        } else {
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 110.0,
                          );
                        }
                      },
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
                    style: const TextStyle(fontFamily: "Poppins"),
                  ),
                  const SizedBox(width: 10.0),
                  const Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                  const Text(
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

  Future<String> fetchImageUrl(String merchantId) async {
    var merchant = (await FirebaseFirestore.instance
        .collection('Merchants')
        .doc(merchantId)
        .get());

    String merchantImage = merchant['imageUrl'];
    return merchantImage;
  }

  Future<String> getDownloadURL(String gsUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewMerchantPage(merchantData: merchant),
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
                    child: FutureBuilder<String>(
                      future: fetchImageUrl(merchant.merchantID).then(
                          (merchantImage) => getDownloadURL(merchantImage)),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(child: Icon(Icons.error)),
                          );
                        } else if (!snapshot.hasData) {
                          return Container(
                            width: double.infinity,
                            height: 110.0,
                            color: Colors.grey[200],
                            child: const Center(child: Icon(Icons.image)),
                          );
                        } else {
                          return Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 110.0,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                merchant.storeName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                merchant.streetAddress,
                style: const TextStyle(fontFamily: "Poppins"),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                  Text(
                    '${merchant.currDistance} km',
                    style: const TextStyle(fontFamily: "Poppins"),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscountCardVertical extends StatelessWidget {
  final MerchantModel merchant;

  const DiscountCardVertical({super.key, required this.merchant});

  Future<String> fetchImageUrl(String merchantId) async {
    var merchant = (await FirebaseFirestore.instance
        .collection('Merchants')
        .doc(merchantId)
        .get());

    String merchantImage = merchant['imageUrl'];
    return merchantImage;
  }

  Future<String> getDownloadURL(String gsUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(gsUrl);
    return await ref.getDownloadURL();
  }

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
                  child: FutureBuilder<String>(
                    future: fetchImageUrl(merchant.merchantID)
                        .then((merchantImage) => getDownloadURL(merchantImage)),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: double.infinity,
                          height: 110.0,
                          color: Colors.grey[200],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          width: double.infinity,
                          height: 110.0,
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.error)),
                        );
                      } else if (!snapshot.hasData) {
                        return Container(
                          width: double.infinity,
                          height: 110.0,
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.image)),
                        );
                      } else {
                        return Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 110.0,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              merchant.storeName,
              style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
