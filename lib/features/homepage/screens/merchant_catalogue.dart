import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../controllers/product_controller.dart';
import '../models/listing_item_model.dart';
import '../models/merchant/catalog_item_model.dart';
import 'add_product_merchant.dart';

class MerchantCatalogue extends StatefulWidget {
  const MerchantCatalogue({super.key});

  @override
  State<MerchantCatalogue> createState() => _MerchantCatalogueState();
}

class _MerchantCatalogueState extends State<MerchantCatalogue> {
  final ProductController _productController = ProductController();
  final ProductController _catalogController = ProductController();
  List<CatalogItemModel> catalogItems = [];
  List<ListingItemModel> products = [];
  var merchant;
  String merchantName = "", merchantId = "";
  bool isLoading = true;

  // int quantity = 0;
  double productPrice = 0;
  bool autoPriceReduction = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Just fetching Merchant Name here :)
    merchant = (await FirebaseFirestore.instance
            .collection('Merchants')
            .where('merchantEmail',
                isEqualTo: FirebaseAuth.instance.currentUser!.email!)
            .get())
        .docs
        .first;
    merchantName = merchant['merchantName'];
    merchantId = merchant['merchantId'];

    List<CatalogItemModel> fetchedCatalogItems =
    await _catalogController.fetchCatalogItems(merchantId);
    List<ListingItemModel> fetchedProducts =
    await _productController.fetchProducts();

    setState(() {
      catalogItems = fetchedCatalogItems;
      products = fetchedProducts;
      isLoading = false;
    });
  }

  Future<void> _addListing(CatalogItemModel item) async {
    // if (_formKey.currentState!.validate()) {
    print("Item name: " + item.productName);
    print("compa: " + item.brandName);
    ListingItemModel newListing = ListingItemModel(
        productId: item.productId,
        merchantId: item.merchantId,
        productName: item.productName,
        brandName: item.brandName,
        basePrice: item.basePrice,
        price: item.price,
        quantity: item.quantity,
        daysUntilExpiry: 1);

    // if (newListing.isBlank != true) {
    //   print("blank");
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('ListingItemModel contains invalid data')),
    //   );
    //   return;
    // }

    List<String> errors = newListing.validate();

    try {
      if (errors.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Listing contains invalid data',
                  style: TextStyle(fontFamily: "Poppins")),
              backgroundColor: TColors.primary),
        );
        for (String error in errors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(error, style: const TextStyle(fontFamily: "Poppins")),
                backgroundColor: TColors.primary),
          );
          print('Validation Error: $error');
        }
      } else {
        await _productController.addListing(newListing);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Listing added successfully',
                  style: TextStyle(fontFamily: "Poppins")),
              backgroundColor: TColors.primary),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error adding listing: $e',
                style: const TextStyle(fontFamily: "Poppins")),
            backgroundColor: TColors.primary),
      );
    }
    // }
  }

  void findingProductInfo(String productIdx) {
    for (ListingItemModel product in products) {
      // print("argument: " + productIdx);
      // print("loop ID: " + product.productId);
      if ((product.productId).compareTo(productIdx) == 0) {
        // print("correct");
        // quantity = product.quantity;
        // print("QUANTITY------------------------------------------------ " + product.quantity.toString());
        productPrice = product.price;
        // print("PRICE------------------------------------------------ " + product.price.toString());
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryBtn,
        title: Text("Hi, $merchantName",
            style: TextStyle(fontFamily: "Poppins", color: Colors.white)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Catalogue',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: catalogItems.length,
                    itemBuilder: (context, index) {
                      final item = catalogItems[index];
                      // print("printing from listview, sending this to function: " + item.productId);
                      findingProductInfo(item.productId);
                      print("product Price : " + productPrice.toString());
                      item.price = productPrice;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: CustomExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.productName,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              Text(
                                '\$${item.price}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Days Until Expiry: 0 Days',
                                      style: const TextStyle(
                                          fontFamily: "Poppins")),
                                  Text('Base Price: \$${item.basePrice}',
                                      style: const TextStyle(
                                          fontFamily: "Poppins")),
                                  const SizedBox(height: 10),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     const Text('Automatic Price Reduction:',
                                  //         style: TextStyle(fontFamily: "Poppins")),
                                  //     Align(
                                  //       alignment: Alignment.centerRight,
                                  //       child: Switch(
                                  //         value: autoPriceReduction,
                                  //         activeColor: TColors.primaryBtn,
                                  //         onChanged: (bool value) {
                                  //           setState(() {
                                  //             autoPriceReduction = value;
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // if (autoPriceReduction) ...[
                                  //   Text(
                                  //       '30% Reduction: 0 Days',
                                  //       style:
                                  //       const TextStyle(fontFamily: "Poppins")),
                                  //   Text(
                                  //       '50% Reduction: 0 Days',
                                  //       style:
                                  //       const TextStyle(fontFamily: "Poppins")),
                                  // ],
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Quantity: ',
                                          style:
                                              TextStyle(fontFamily: "Poppins")),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    if (item.quantity > 0)
                                                      item.quantity--;
                                                  });
                                                },
                                              ),
                                              Text('${item.quantity}',
                                                  style: const TextStyle(
                                                      fontFamily: "Poppins")),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    item.quantity++;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _addListing(item);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: TColors.primaryBtn,
                                        ),
                                        child: const Text('Add To Listing',
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.white)),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text('Edit Product',
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductPage()));
        },
        backgroundColor: TColors.primaryBtn,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  const CustomExpansionTile(
      {super.key, required this.title, required this.children});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: widget.title,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Column(
            children: widget.children,
          ),
      ],
    );
  }
}
