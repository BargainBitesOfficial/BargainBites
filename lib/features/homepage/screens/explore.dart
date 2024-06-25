import 'package:bargainbites/features/homepage/screens/store_details_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  bool isLoading = true;
  String currDay = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchMerchants();
  }

  Future<void> _fetchMerchants() async {
    List<MerchantModel> fetchedMerchants = await _exploreController.fetchMerchants();

    // calculating the distance of merchants with current location
    for (MerchantModel merchant in fetchedMerchants) {
      //double distance = await _exploreController.getDistanceByRoad("N9B 2K9", merchant.postalCode, "");
      //merchant.currDistance = (distance != -1.0) ? distance : -1;

      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      merchant.merchantRating = double.parse((3.0 + (5.0 - 3.0) * random.nextDouble()).toStringAsFixed(1));
    }
    setState(() {
      merchants = fetchedMerchants;
      isLoading = false;
    });
  }

  Future<void> _refreshItems() async {
    // Simulate a network call and refresh the list
    List<MerchantModel> fetchedMerchants = await _exploreController.fetchMerchants();

    // calculating the distance of merchants with current location
    for (MerchantModel merchant in fetchedMerchants) {
      //double distance = await _exploreController.getDistanceByRoad("N9B 2K9", merchant.postalCode, "");
      //merchant.currDistance = (distance != -1.0) ? distance : -1;

      final random = Random();
      double temp = 2.0 + (10.0 - 2.0) * random.nextDouble();
      merchant.currDistance = double.parse(temp.toStringAsFixed(1));
      merchant.merchantRating = double.parse((3.0 + (5.0 - 3.0) * random.nextDouble()).toStringAsFixed(1));
    }

    setState(() {
      merchants = fetchedMerchants;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: TColors.linerGradient,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
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
                              // Text('within 10 km',
                              //   style: TextStyle(
                              //     fontFamily: "Poppins",
                              //     fontSize: 12,
                              //     color: Colors.white
                              //   )
                              // ),
                            ],
                          ),
                        ),
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
                              color: TColors.primary, // Match the background gradient
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                            ),
                          ),
                        ),
                      ]
                  ),
                  // const Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(children: [
                  //       Text('University Avenue Windsor, N9B 2Y8',
                  //           style: TextStyle(
                  //               fontFamily: "Poppins",
                  //               fontSize: 14,
                  //               color: Colors.white)),
                  //     ]),
                  //     Text('within 10 km',
                  //         style: TextStyle(
                  //             fontFamily: "Poppins",
                  //             fontSize: 14,
                  //             color: Colors.white)),
                  //   ]),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: TextField(
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

          // put padding part here..

          // explore starts from here
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Explore',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Poppins'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                itemCount: merchants.length,
                itemBuilder: (context, index) {
                  final item = merchants[index];
                  String openStatusMsg = "";
                  bool isGreyed = false;
                  if (item.isOpened == false || item.storeTiming?[currDay]?['openingTime'] == Null || item.storeTiming?[currDay]?['openingTime'] == "") {
                    openStatusMsg = "Closed";
                    isGreyed = true;
                  }
                  else {
                    openStatusMsg = "Open today from ${item.storeTiming?['Monday']?['openingTime']} to ${item.storeTiming?['Monday']?['closingTime']}";
                    isGreyed = false;
                  }

                  // calculating distance between location
                  //String apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';

                  return Card(
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // This gives the depth effect
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StoreDetailsPage()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ColorFiltered(colorFilter: isGreyed
                              ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                              : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15)),
                              child: Image.asset(
                                'assets/images/grocery.jpg',
                                width: double.infinity,
                                height: 150, // Set a height for the image
                                fit: BoxFit.cover, // This makes the image expand to fill the width
                              ),
                            ),
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
                                    fontSize:14,
                                    fontFamily: 'Poppins',
                                    color: isGreyed ? TColors.greyText : TColors.greyText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: isGreyed ? TColors.greyText : TColors.starIconColor ,
                                        size: 16),
                                    Text(' ${item.merchantRating}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isGreyed ? TColors.greyText : TColors.bBlack,
                                          fontFamily: 'Poppins'
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(Icons.location_on,
                                        color: isGreyed ? TColors.greyText : TColors.locationIconColor,
                                        size: 16),
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