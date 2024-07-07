import 'package:bargainbites/features/cart/models/cart_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../controllers/cart_controller.dart';

class CartListPage extends StatefulWidget {
  final String userId = "pNEZZkusrUZ3cksfmBf3S5hJabv1";

  @override
  _CartListPageState createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {

  late Future<List<CartModel>> carts;
  final CartController _cartController = CartController();

  @override
  void initState() {
    super.initState();
    carts = _cartController.fetchCartsByUserName(widget.userId);
  }

  void _clearCart(String cartId) async{
    await _cartController.removeCart(cartId);
    setState(() {
      carts = _cartController.fetchCartsByUserName(widget.userId);
    });
  }

  Future<void> _refreshCarts() async {
    setState(() {
      carts = _cartController.fetchCartsByUserName(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

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
              return Center(child: Text('No carts found for ${widget.userId}'));
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
                          '${carts.length} items · \$${cart.total}',
                          style: const TextStyle(fontFamily: 'poppins'),
                        ),
                        Text('Pick up from ${cart.merchantAddress}'),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle view cart
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
                              onPressed: () {
                                // Handle view store
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
