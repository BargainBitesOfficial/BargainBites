import 'package:bargainbites/features/authentication/models/merchant_model.dart';
import 'package:bargainbites/features/cart/controllers/cart_controller.dart';
import 'package:bargainbites/features/cart/models/cart_model.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/colors.dart';

import '../../order/screens/product_page.dart';

class ViewMerchantPage extends StatefulWidget {
  final MerchantModel merchantData;

  const ViewMerchantPage({super.key, required this.merchantData});

  @override
  State<ViewMerchantPage> createState() => _ViewMerchantPageState();
}

class _ViewMerchantPageState extends State<ViewMerchantPage> {
  final ProductController _productController = ProductController();
  CartController _cartController = CartController();
  List<ListingItemModel> listedProducts = [];
  CartModel? _cartModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductsByMerchant();
    _fetchCartByMerchant();
  }

  Future<void> _fetchProductsByMerchant() async {
    List<ListingItemModel> fetchedProducts = await _productController.fetchProductsByMerchant(widget.merchantData.merchantID);

    setState(() {
      listedProducts = fetchedProducts;
      isLoading = false;
    });
  }

  Future<void> _fetchCartByMerchant() async {
    // initializing cart model for particular merchant.
    CartModel? cartModel = await _cartController.getCartIfExists(widget.merchantData.merchantID);

    cartModel ??= await _cartController.getCartInstance(widget.merchantData);

    setState(() {
      _cartModel = cartModel;
      isLoading = false;
    });
  }

  Future<String> fetchImageUrlPrdt(String productId) async {
    var product = (await FirebaseFirestore.instance
        .collection('CatalogItems')
        .where('productID', isEqualTo: productId)
        .get())
        .docs
        .first;

    String productImage = product['itemImage'];
    return productImage;
  }

  Future<String> fetchImageUrl(String merchantId) async {
    var merchant = (await FirebaseFirestore.instance
        .collection('Merchants')
        .where('merchantID', isEqualTo: merchantId)
        .get())
        .docs
        .first;

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
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar with image and back button
          FutureBuilder<String>(
            future: fetchImageUrl(widget.merchantData.merchantID)
                .then((merchantImage) => getDownloadURL(merchantImage)),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(
                      child: Icon(Icons.error, color: Colors.red)),
                );
              } else if (!snapshot.hasData) {
                return Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: Center(
                      child: Icon(Icons.image, color: Colors.grey[700])),
                );
              } else {
                return Stack(
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!),
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
                );
              }
            },
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
                      widget.merchantData.storeName,
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(product: item, cartModel: _cartModel)));
                    },
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
                            FutureBuilder<String>(
                              future: fetchImageUrlPrdt(item.productId)
                                  .then((productImage) => getDownloadURL(productImage)),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: const Center(child: CircularProgressIndicator()),
                                  );
                                } else if (snapshot.hasError) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: const Center(
                                        child: Icon(Icons.error, color: Colors.red)),
                                  );
                                } else if (!snapshot.hasData) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: Center(
                                        child: Icon(Icons.image, color: Colors.grey[700])),
                                  );
                                } else {
                                  return Image.network(
                                    snapshot.data!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
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
                  ),
                );
              },
            ),
          )
          ,
        ],
      ),
    );
  }

  String openStatusMsg(MerchantModel item) {
    if (item.isOpened) {
      return "Open";
    } else {
      return "Closed";
    }
  }
}
