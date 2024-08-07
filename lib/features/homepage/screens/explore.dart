import 'package:bargainbites/features/homepage/screens/view_merchant_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../../../utils/constants/colors.dart';
import '../../authentication/models/merchant_model.dart';
import '../controllers/explore_controller.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ExploreController _exploreController = ExploreController();
  List<MerchantModel> merchants = [];
  List<MerchantModel> filteredMerchants = [];
  bool isLoading = true;
  String currDay = DateFormat('EEEE').format(DateTime.now());
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMerchants();
    _searchController.addListener(_filterMerchants);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterMerchants);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchMerchants() async {
    List<MerchantModel> fetchedMerchants = await _exploreController.fetchMerchants();

    for (MerchantModel merchant in fetchedMerchants) {
      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      merchant.merchantRating = double.parse((3.0 + (5.0 - 3.0) * random.nextDouble()).toStringAsFixed(1));
    }
    setState(() {
      merchants = fetchedMerchants;
      filteredMerchants = fetchedMerchants;
      isLoading = false;
    });
  }

  void _filterMerchants() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredMerchants = merchants.where((merchant) {
        return merchant.storeName.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _refreshItems() async {
    List<MerchantModel> fetchedMerchants = await _exploreController.fetchMerchants();
    for (MerchantModel merchant in fetchedMerchants) {
      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      merchant.merchantRating = double.parse((3.0 + (5.0 - 3.0) * random.nextDouble()).toStringAsFixed(1));
    }

    setState(() {
      merchants = fetchedMerchants;
      filteredMerchants = fetchedMerchants;
      isLoading = false;
    });
  }

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: TColors.linerGradient,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Browse',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: TColors.bWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('University Avenue, 3.2 km',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.white
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
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
                      ]
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search, color: Colors.black54),
                              filled: true,
                              fillColor: TColors.bWhite,
                              hintText: 'Search with filters & browse',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.tune, color: TColors.primary),
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              )
          ),
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text('Explore',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'Poppins'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('see all',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Poppins'
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshItems,
              child: ListView.builder(
                itemCount: filteredMerchants.length,
                itemBuilder: (context, index) {
                  final item = filteredMerchants[index];
                  String openStatusMsg = "";
                  bool isGreyed = false;
                  if (item.isOpened == false || item.storeTiming?[currDay]?['openingTime'] == null || item.storeTiming?[currDay]?['openingTime'] == "") {
                    openStatusMsg = "Closed";
                    isGreyed = true;
                  } else {
                    openStatusMsg = "Open today from ${item.storeTiming?['Monday']?['openingTime']} to ${item.storeTiming?['Monday']?['closingTime']}";
                    isGreyed = false;
                  }

                  return Card(
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMerchantPage(merchantData: item)));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: fetchImageUrl(item.merchantID).then((merchantImage) => getDownloadURL(merchantImage)),
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[200],
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              } else if (snapshot.hasError) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[200],
                                  child: Center(child: Icon(Icons.error)),
                                );
                              } else if (!snapshot.hasData) {
                                return Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[200],
                                  child: Center(child: Icon(Icons.image)),
                                );
                              } else {
                                return ColorFiltered(
                                  colorFilter: isGreyed
                                      ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                                      : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                    child: Image.network(
                                      snapshot.data!,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.storeName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isGreyed ? TColors.greyText : TColors.bBlack,
                                      fontFamily: 'Poppins'
                                  ),
                                ),
                                Text(openStatusMsg,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: isGreyed ? TColors.greyText : TColors.greyText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: isGreyed ? TColors.greyText : TColors.starIconColor, size: 16),
                                    Text(' ${item.merchantRating}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isGreyed ? TColors.greyText : TColors.bBlack,
                                          fontFamily: 'Poppins'
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(Icons.location_on, color: isGreyed ? TColors.greyText : TColors.locationIconColor, size: 16),
                                    Text('${item.currDistance} km',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isGreyed ? TColors.greyText : TColors.bBlack,
                                          fontFamily: 'Poppins'
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
