import 'package:bargainbites/features/authentication/models/merchant_model.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/merchant/catalog_item_model.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/colors.dart';

class ViewMerchantPage extends StatefulWidget {
  final MerchantModel merchantData;

  ViewMerchantPage({super.key, required this.merchantData});

  @override
  _ViewMerchantPageState createState() => _ViewMerchantPageState();
}

class _ViewMerchantPageState extends State<ViewMerchantPage> {
  ProductController _productController = ProductController();
  List<ListingItemModel> listedProducts = [];
  // List<CatalogItemModel> catalogItems = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductsByMerchant();
  }

  Future<void> _fetchProductsByMerchant() async {
    List<ListingItemModel> fetchedProducts = await _productController.fetchProductsByMerchant(widget.merchantData.merchantId);

    // for (ListingItemModel item in fetchedProducts) {
    //   print("productId: " + item.productId);
    //   CatalogItemModel? product = await _productController.fetchItemById("6lAzd42FQ2LbZtYJIFcI");
    //   print("productName: " + product!.productName);
    // }

    setState(() {
      listedProducts = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar with image and back button
          Stack(
            children: [
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/grocery.jpg'), // replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40, // Adjust according to your needs
                left: 10, // Adjust according to your needs
                child: CircleAvatar(
                  backgroundColor: Colors.black54, // Background color for the button
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: TColors.bWhite),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
          // Merchant info card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.merchantData.merchantName,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      openStatusMsg(widget.merchantData),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: TColors.primary, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          widget.merchantData.streetAddress,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.directions_walk, color: TColors.primary, size: 16),
                        const SizedBox(width: 5),
                        Text(
                          '${widget.merchantData.currDistance} km',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: TColors.starIconColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.white, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                widget.merchantData.merchantRating.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // All Items title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'All Items',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              itemCount: listedProducts.length, // Use dynamic item count
              itemBuilder: (context, index) {
                final item = listedProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Product image
                          Image.network(
                            'gs://bargainbites-f6682.appspot.com/ProductImages/dr_pepper.jpg',
                            // catalogItems[index].itemImage,
                            width: 50, // Set the desired width
                            height: 50, // Set the desired height
                            fit: BoxFit.cover, // Set the fit property to cover
                          ),
                          const SizedBox(width: 10),
                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Quantity: ${item.quantity}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$${item.price}', // Replace with your dynamic product price
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String openStatusMsg(MerchantModel item) {
    String openStatusMsg = "";
    String currDay = DateFormat('EEEE').format(DateTime.now());
    bool isGreyed = false;
    if (item.isOpened == false ||
        item.storeTiming?[currDay]?['openingTime'] == null ||
        item.storeTiming?[currDay]?['openingTime'] == "") {
      openStatusMsg = "Closed";
      isGreyed = true;
    } else {
      openStatusMsg =
      "Open today from ${item.storeTiming?['Monday']?['openingTime']} to ${item.storeTiming?['Monday']?['closingTime']}";
      isGreyed = false;
    }
    return openStatusMsg;
  }
}
