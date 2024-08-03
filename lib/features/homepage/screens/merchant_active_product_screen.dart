import 'package:bargainbites/utils/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

class ActiveProductsPage extends StatefulWidget {
  const ActiveProductsPage({super.key});

  @override
  State<ActiveProductsPage> createState() => _ActiveProductsPageState();
}

class _ActiveProductsPageState extends State<ActiveProductsPage> {
  final ProductController _productController = ProductController();
  String merchantName = "", merchantId = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMerchant();
  }

  var merchant;

  Future<void> fetchMerchant() async {
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
    setState(() {
      merchantName = merchant['storeName'];
      merchantId = merchant['merchantID'];
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    await fetchMerchant();
    // await
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await _productController.deleteProduct(productId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully')),
      );

      _refreshData(); // Refresh the data after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $e')),
      );
    }
  }

  void _confirmDeleteProduct(String productId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteProduct(productId);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Hi, $merchantName",
            style: const TextStyle(fontFamily: "Poppins", color: Colors.white)),
        backgroundColor: TColors.primary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Expired Listings",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FutureBuilder<List<ListingItemModel>>(
                        future:
                            _productController.fetchExpiredProducts(merchantId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('There are no expired products'));
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
                    // const SizedBox(height: 20),
                    const Text(
                      "All Active Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FutureBuilder<List<ListingItemModel>>(
                        future: _productController
                            .fetchSpecificProducts(merchantId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No active products found'));
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
            ),
    );
  }

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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Icon(Icons.error, color: Colors.red));
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
            Text('Price: \$${product.price}/qty'),
            Text(
              '${product.brandName} - Base Price: \$${product.basePrice}',
              style: const TextStyle(color: Colors.red),
            ),
            Text('Remaining Qty: ${product.quantity}'),
            Text('Expiring On: ${product.expiringOn.toString().split(" ")[0]}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_sharp),
          onPressed: () => _confirmDeleteProduct(product.productId),
        ),
      ),
    );
  }
}
