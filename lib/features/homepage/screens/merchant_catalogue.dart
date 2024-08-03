import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:bargainbites/features/homepage/models/merchant/catalog_item_model.dart';
import 'add_product_merchant.dart';
import 'edit_product.dart';

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
  String merchantName = "", merchantId = "", storeName = "";
  bool isLoading = true;
  bool autoPriceReduction = false;

  // final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    merchant = (await FirebaseFirestore.instance
            .collection('Merchants')
            .where('merchantEmail',
                isEqualTo: FirebaseAuth.instance.currentUser!.email!)
            .get())
        .docs
        .first;
    merchantName = merchant['merchantName'];
    merchantId = merchant['merchantID'];
    storeName = merchant['storeName'];

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
    final price = double.tryParse(item.price.toString()) ?? 0.0;
    ListingItemModel newListing = ListingItemModel(
        productId: item.productId,
        merchantId: item.merchantId,
        productName: item.productName,
        brandName: item.brandName,
        basePrice: item.basePrice,
        price: price,
        quantity: item.quantity,
        expiringOn: item.expiringOn);

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
        }
      } else {
        await _productController.addListing(newListing);
        setState(() {
          item.price = 0; // Reset the price to 0 after adding the listing
        });
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
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await _productController.deleteCatalogProduct(productId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
      _fetchProducts(); // Refresh the data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $e')),
      );
    }
  }

  void findingProductInfo(String productIdx) {
    for (ListingItemModel product in products) {
      if ((product.productId).compareTo(productIdx) == 0) {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: TColors.primaryBtn,
        title: const Text("Catalogue",
            style: TextStyle(fontFamily: "Poppins", color: Colors.white)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchProducts,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        findingProductInfo(item.productId);
                        return Dismissible(
                          key: Key(item.productId),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _deleteProduct(item.productId);
                          },
                          background: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(Icons.delete_outline_sharp,
                                  color: Colors.white),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: CustomExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.productName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      initialValue: item.price.toString(),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Price',
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          item.price =
                                              double.tryParse(value) ?? 0;
                                        });
                                      },
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        initialValue: '',
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: item.expiringOn != null
                                              ? 'Expiring On: ${DateFormat('yyyy-MM-dd').format(item.expiringOn!)}'
                                              : 'Expiring On',
                                          suffixIcon:
                                              const Icon(Icons.calendar_today),
                                        ),
                                        readOnly: true,
                                        onTap: () async {
                                          final DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (picked != null) {
                                            setState(() {
                                              item.expiringOn = picked;
                                            });
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      Text('Base Price: \$${item.basePrice}',
                                          style: const TextStyle(
                                              fontFamily: "Poppins")),
                                      const SizedBox(height: 10),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Quantity: ',
                                              style: TextStyle(
                                                  fontFamily: "Poppins")),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.remove),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (item.quantity > 0)
                                                          item.quantity--;
                                                      });
                                                    },
                                                  ),
                                                  Text('${item.quantity}',
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              "Poppins")),
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
                                              backgroundColor:
                                                  TColors.primaryBtn,
                                            ),
                                            child: const Text('Add To Listing',
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: Colors.white)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProductPage(
                                                          item: item),
                                                ),
                                              );
                                            },
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddProductPage(
                      storeName: storeName, merchantID: merchantId)));
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
