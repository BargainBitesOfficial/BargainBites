import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ListingItemModel>> fetchProducts() async {
    try {
      //only fetching validated stores.
      QuerySnapshot snapshot =
          await _firestore.collection('ActiveProductList').get();
      List<ListingItemModel> productList = snapshot.docs
          .map((doc) =>
              ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
