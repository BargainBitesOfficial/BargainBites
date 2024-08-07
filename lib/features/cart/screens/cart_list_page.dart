import 'package:bargainbites/features/cart/models/cart_model.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../authentication/models/merchant_model.dart';
import '../../homepage/screens/view_merchant_page.dart';
import '../../order/screens/confirm_order.dart';
import '../controllers/cart_controller.dart';

class CartListPage extends StatefulWidget {

  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {

  late Future<List<CartModel>> carts;
  final CartController _cartController = CartController();

  @override
  void initState() {
    super.initState();
    carts = _cartController.fetchCartsByUser();
  }

  void _clearCart(String cartId) async{
    await _cartController.removeCart(cartId);
    setState(() {
      carts = _cartController.fetchCartsByUser();
    });
  }

  Future<void> _refreshCarts() async {
    setState(() {
      carts = _cartController.fetchCartsByUser();
    });
  }

  double _calculateSubtotal(CartModel cart) {
    double subtotal = 0;
    subtotal = cart.items.fold(0.0, (sum, item) {
      int quantity = cart.itemQuantity[item.productId] ?? 0;
      return sum + (item.price * quantity);
    });
    return subtotal;
  }

  String _formatCartSummary(CartModel cart) {
    final itemCount = cart.itemQuantity.values.fold(0, (previousValue, element) => previousValue + element);
    final totalPrice = _calculateSubtotal(cart);
    return '$itemCount items · \$${totalPrice.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carts'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCarts,
        child: FutureBuilder<List<CartModel>>(
          future: carts,
          builder: (BuildContext context, AsyncSnapshot<List<CartModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: TColors.primary, strokeWidth: 5,));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No carts found'));
            }

            final carts = snapshot.data!;

            return ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                final cart = carts[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 23,
                              child: Text(
                                  cart.merchantName[0],
                                  style: const TextStyle(fontFamily: 'poppins', fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cart.merchantName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins'
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _clearCart(cart.cartId);
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _formatCartSummary(cart),
                          style: const TextStyle(fontFamily: 'poppins'),
                        ),
                        Text('Pick up from ${cart.merchantAddress}'),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmOrderPage(cartModel: cart),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                              ),
                              child: const Text('View cart',
                                style: TextStyle(
                                    color: TColors.bWhite,
                                    fontSize: 16
                                ),),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () async {
                                try {
                                  MerchantModel merchantData = await _cartController.fetchMerchantById(cart.merchantId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewMerchantPage(merchantData: merchantData),
                                    ),
                                  );
                                } catch (e) {
                                  // Handle error
                                  print('Error fetching merchant data: $e');
                                }
                              },
                              child: const Text('View store',
                                style: TextStyle(
                                    color: TColors.bBlack,
                                    fontSize: 16
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
            );
          },
        ),
      ),
    );
  }
}
