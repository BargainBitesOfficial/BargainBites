import 'package:bargainbites/features/authentication/models/merchant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/features/cart/models/cart_model.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CartModel>> fetchCartsByUser() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Carts')
        .where('userId', isEqualTo: getUserId())
        .get();

    // Get the list of documents from the query snapshot
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    // Map each document to a CartModel
    List<CartModel> carts = documents.map((QueryDocumentSnapshot doc) {
      // Cast the document data to a Map<String, dynamic>
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print("data"+data.toString());
      // Create a CartModel from the map
      return CartModel.fromJson(data);
    }).toList();

    // Return the list of CartModels
    return carts;
  }

  Future<void> removeCart(String cartId) async {
    await _firestore.collection('Carts').doc(cartId).delete();
  }

  Future<CartModel> getCartInstance(MerchantModel merchantData)  async {

    print("before getting info");

    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Carts');
    DocumentReference docRef = collectionRef.doc();

    print("merchnatNameIs: " + merchantData.merchantName + merchantData.streetAddress);

    CartModel cartModel = CartModel(
        cartId: docRef.id,
        merchantId: merchantData.merchantID,
        merchantName: merchantData.merchantName,
        merchantAddress: merchantData.streetAddress,
        userId: getUserId(),
        items: [],
        total: 0.0
    );

    // updating initial cart information
    await docRef.set(cartModel.toJson());

    print("newcart id: " + cartModel.cartId);
    return cartModel;
  }

  Future<CartModel?> getCartIfExists(String merchantId) async {

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Carts')
          .where('merchantId', isEqualTo: merchantId)
          .get();

      // Get the list of documents from the query snapshot
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      if (documents.isNotEmpty) {
        // Map the first document to a CartModel
        Map<String, dynamic> data = documents[0].data() as Map<String, dynamic>;
        print("cartdata: " + data.toString());
        CartModel cart = CartModel.fromJson(data);
        print("new cart id: ${cart.cartId}");

        // Return the first CartModel
        return cart;
      }
      else {
        // No documents found
        print("No cart found for merchantId: $merchantId");
        return null;
      }
    }
    catch (e) {
      print("Error in fetching cart: $e");
      return null;
    }
  }

  Future<MerchantModel> fetchMerchantById(String merchantId) async {
    try {
      DocumentSnapshot merchantSnapshot = await _firestore.collection('Merchants').doc(merchantId).get();
      if (merchantSnapshot.exists) {
        return MerchantModel.fromMap(merchantSnapshot.data() as Map<String, dynamic>);
      }
      else {
        throw Exception('Merchant not found');
      }
    } catch (e) {
      throw Exception('Error fetching merchant: $e');
    }
  }

  String getUserId() {
    final User? _user = FirebaseAuth.instance.currentUser;
    print("user id is: " + ((_user!= null) ? _user.uid : "XYZ"));
    return (_user!= null) ? _user.uid : "";
  }
}
