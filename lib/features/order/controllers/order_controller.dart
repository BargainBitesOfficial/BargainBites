import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

import '../../cart/models/cart_model.dart';

class OrderController {
  final CollectionReference _cartCollection = FirebaseFirestore.instance.collection('Carts');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updateCart(CartModel? cartModel) async {
    print("update cart data: " + cartModel!.items.length.toString());
    if (cartModel == null) {
      print('CartModel is null');
      return false;
    }

    try {
      DocumentReference docRef = _cartCollection.doc(cartModel.cartId);
      await docRef.update(cartModel.toJson());
      return true;  // Update was successful
    }
    catch (e) {
      print('Error updating cart: $e');
      return false;  // Update failed
    }
  }

  Future<String> fetchProductImageUrl(String productId) async {
    print("product ID; " + productId);
    DocumentSnapshot snapshot = await _firestore.collection('CatalogItems').doc(productId).get();
    print(snapshot.exists);
    print(snapshot.data());
    try {
      if (snapshot.exists && snapshot.data() != null) {
        print("IMage url: " + snapshot['itemImage']);
        return snapshot['itemImage'];
      }
      // else {
      //   throw Exception('Product image URL not found');
      // }
    }
    catch (e) {
      print(e.toString());
      return "";
    }
    return "";
  }

}
