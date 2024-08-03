import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bargainbites/features/cart/models/cart_model.dart';

class CartController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CartModel>> fetchCartsByUserName(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Carts')
        .where('userId', isEqualTo: userId)
        .get();
    
    // Get the list of documents from the query snapshot
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    // Map each document to a CartModel
    List<CartModel> carts = documents.map((QueryDocumentSnapshot doc) {
      // Cast the document data to a Map<String, dynamic>
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Create a CartModel from the map
      return CartModel.fromJson(data);
    }).toList();

    // Return the list of CartModels
    return carts;
  }

  Future<void> removeCart(String cartId) async {
    await _firestore.collection('Carts').doc(cartId).delete();
  }

}
