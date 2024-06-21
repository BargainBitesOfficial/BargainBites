import 'package:flutter/material.dart';

class Store {
  static const String name = 'Circle K';
  static const String address = '1201 Wyandotte Street';
}

class ConfirmOrderPage extends StatefulWidget {
  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final List<OrderItem> items = [
    OrderItem(
      title: 'Item Name 1',
      discount: '50% OFF',
      price: 28.8,
      quantity: 3,
    ),
    OrderItem(
      title: 'Item Name 2',
      discount: '30% OFF',
      price: 28.8,
      quantity: 3,
    ),
    OrderItem(
      title: 'Item Name 3',
      discount: '10% OFF',
      price: 28.8,
      quantity: 3,
    ),
  ];

  double _calculateSubtotal() {
    double subtotal = 0;
    for (var item in items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  void _increaseQuantity(int index) {
    setState(() {
      items[index].quantity++;
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      } else {
        items.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double taxAndFees = subtotal * 0.13; // 13% tax and fees
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
                      '${Store.name} - ${Store.address}',
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.network(
                          'https://via.placeholder.com/100',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(item.discount),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '\$${(item.price).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => _decreaseQuantity(index),
                                ),
                                Text('${item.quantity}'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => _increaseQuantity(index),
                                ),
                              ],
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed To Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '\$${total.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
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

class OrderItem {
  final String title;
  final String discount;
  final double price;
  int quantity;

  OrderItem({
    required this.title,
    required this.discount,
    required this.price,
    required this.quantity,
  });
}
