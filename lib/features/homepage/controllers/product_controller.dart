import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/merchant/catalog_item_model.dart';

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

  Future<List<ListingItemModel>> fetchSpecificProducts(
      String merchantId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('ActiveProductList')
          .where('merchantID', isEqualTo: merchantId)
          .get();
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

  Future<List<CatalogItemModel>> fetchCatalogItems(String merchantId) async {
    try {
      //only fetching validated stores.
      QuerySnapshot snapshot =
          await _firestore.collection('CatalogItems').where('merchantId', isEqualTo: merchantId).get();
      List<CatalogItemModel> productList = snapshot.docs
          .map((doc) =>
              CatalogItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching catalog: $e');
      return [];
    }
  }

  Future<List<ListingItemModel>> addListing(ListingItemModel listing) async {
    try {
      await _firestore.collection('ActiveProductList').add(listing.toJson());
    } catch (e) {
      print('Error adding listing: $e');
      throw e;
    }
    return [];
  }

  Future<CatalogItemModel?> fetchItemById(String id) async {
    try {
      //only fetching validated stores.
      DocumentSnapshot doc = await _firestore.collection('CatalogItems').doc(id).get();
      if (doc.exists) {
        CatalogItemModel product = CatalogItemModel.fromMap(doc.data() as Map<String, dynamic>);
        print("product in c: " + product.productName);
        return product;
      }
      return null;
    }
    catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }

  Future<List<ListingItemModel>> fetchProductsByMerchant(String id) async {
    try {
      //only fetching validated stores.
      QuerySnapshot snapshot =
      await _firestore.collection('ActiveProductList').where('merchantID', isEqualTo: id).get();
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
