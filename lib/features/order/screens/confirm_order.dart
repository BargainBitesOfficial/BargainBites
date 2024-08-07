import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:bargainbites/features/order/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/features/cart/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ConfirmOrderPage extends StatefulWidget {
  final CartModel cartModel;

  ConfirmOrderPage({required this.cartModel});

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late List<ListingItemModel> carts;
  OrderController orderController = OrderController();
  Map<String, String> imageUrls = {};

  @override
  void initState() {
    super.initState();
    carts = widget.cartModel.items;
    _fetchImageUrls();
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

  void _fetchImageUrls() async {
    for (var item in carts) {
      String productImage = await fetchImageUrl(item.productId);
      String imageUrl = await getDownloadURL(productImage);
      setState(() {
        imageUrls[item.productId] = imageUrl;
      });
    }
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    subtotal = widget.cartModel.items.fold(0.0, (sum, item) {
      int quantity = widget.cartModel.itemQuantity[item.productId] ?? 0;
      return sum + (item.price * quantity);
    });
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double taxAndFees = subtotal * .13; // 13% tax and fees
    double total = subtotal + taxAndFees;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Confirm Order'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.cartModel.merchantName} - ${widget.cartModel.merchantAddress}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: carts.length,
              itemBuilder: (context, index) {
                final item = carts[index];
                final imageUrl = imageUrls[item.productId];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        FutureBuilder<String>(
                          future: fetchImageUrl(item.productId)
                              .then((productImage) => getDownloadURL(productImage)),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            } else if (!snapshot.hasData) {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.image, color: Colors.grey[700]),
                              );
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  snapshot.data!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.brandName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${item.basePrice.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '\$${item.price.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                'Quantity: ${widget.cartModel.itemQuantity[item.productId]}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildPriceRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
                _buildPriceRow('Fees & Estimated Tax', '\$${taxAndFees.toStringAsFixed(2)}'),
                _buildPriceRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed To Checkout',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
