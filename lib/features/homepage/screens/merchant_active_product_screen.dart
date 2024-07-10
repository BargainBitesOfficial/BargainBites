import 'package:flutter/material.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

class ActiveProductsPage extends StatefulWidget {
  final String merchantId;

  ActiveProductsPage({required this.merchantId});

  @override
  _ActiveProductsPageState createState() => _ActiveProductsPageState();
}

class _ActiveProductsPageState extends State<ActiveProductsPage> {
  final ProductController _productController = ProductController();
  late Future<List<ListingItemModel>> _activeProductsFuture;

  @override
  void initState() {
    super.initState();
    _activeProductsFuture = _productController.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, Circle K"),
        backgroundColor: Colors.green,
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
                future: _activeProductsFuture,
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
    List<ListingItemModel> expiringSoon = products.where((product) => product.daysUntilExpiry < 2).toList();
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
          child: Icon(Icons.image, size: 30, color: Colors.grey[700]),
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
