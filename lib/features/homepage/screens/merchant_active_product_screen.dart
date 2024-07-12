import 'package:bargainbites/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

class ActiveProductsPage extends StatefulWidget {
  // QueryDocumentSnapshot<Map<String, dynamic>> merchant;

  ActiveProductsPage({super.key});

  @override
  _ActiveProductsPageState createState() => _ActiveProductsPageState();
}

class _ActiveProductsPageState extends State<ActiveProductsPage> {
  final ProductController _productController = ProductController();
  late Future<List<ListingItemModel>> _activeProductsFuture;

  String merchantName = "", merchantId = "";

  @override
  void initState() {
    super.initState();
    fetchMerchant();
  }

  var merchant;

  Future<void> fetchMerchant() async {
    // Just fetching Merchant Name here :)
    merchant = (await FirebaseFirestore.instance
            .collection('Merchants')
            .where('merchantEmail',
                isEqualTo: FirebaseAuth.instance.currentUser!.email!)
            .get())
        .docs
        .first;
    setState(() {
      merchantName = merchant['merchantName'];
      merchantId = merchant['merchantId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, $merchantName",
            style: TextStyle(fontFamily: "Poppins", color: Colors.white)),
        backgroundColor: TColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Listings expiring soon",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<ListingItemModel>>(
              future: _productController.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No expiring products found'));
                } else {
                  return _buildExpiringListings(snapshot.data!);
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              "All Active Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<ListingItemModel>>(
                future: _productController.fetchSpecificProducts(merchantId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No active products found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return _buildProductCard(product);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiringListings(List<ListingItemModel> products) {
    List<ListingItemModel> expiringSoon =
        products.where((product) => product.daysUntilExpiry < 2).toList();
    return Row(
      children: expiringSoon.map((product) {
        return Expanded(
          child: Card(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    product.productName,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Expiring in ${product.daysUntilExpiry} days",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${product.quantity} qty remaining",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<String> fetchImageUrl(String productId) async {
    var product = (await FirebaseFirestore.instance
            .collection('CatalogItems')
            .where('productId', isEqualTo: productId)
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

  Widget _buildProductCard(ListingItemModel product) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[300],
          ),
          child: FutureBuilder<String>(
            future: fetchImageUrl(product.productId)
                .then((productImage) => getDownloadURL(productImage)),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Icon(Icons.error, color: Colors.red));
              } else if (!snapshot.hasData) {
                return Icon(Icons.image, size: 30, color: Colors.grey[700]);
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                );
              }
            },
          ),
        ),
        title: Text(product.productName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID #${product.listingId} - Price: \$${product.price}/qty'),
            Text(
              '${product.brandName} - Base Price: \$${product.basePrice}',
              style: TextStyle(color: Colors.red),
            ),
            Text('Remaining Qty: ${product.quantity}'),
            Text('Product Expiry: ${product.daysUntilExpiry} days'),
          ],
        ),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
