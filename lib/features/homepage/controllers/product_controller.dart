import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/merchant/catalog_item_model.dart';

class ProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ListingItemModel>> fetchProducts() async {
    try {
      final now = DateTime.now();
      //only fetching validated stores.
      QuerySnapshot snapshot =
          await _firestore.collection('ActiveProductList').get();
      // List<ListingItemModel> productList = snapshot.docs
      //     .map((doc) =>
      //         ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
      //     .toList();

      List<ListingItemModel> productList = snapshot.docs
          .map((doc) => ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((product) => product.expiringOn!.isAfter(now)) // Filter out expired products
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
      final now = DateTime.now();
      QuerySnapshot snapshot = await _firestore
          .collection('ActiveProductList')
          .where('merchantID', isEqualTo: merchantId)
          .get();
      List<ListingItemModel> productList = snapshot.docs
          .map((doc) => ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((product) => product.expiringOn!.isAfter(now)) // Filter out expired products
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<ListingItemModel>> fetchExpiredProducts(
      String merchantId) async {
    try {
      final now = DateTime.now();
      QuerySnapshot snapshot = await _firestore
          .collection('ActiveProductList')
          .where('merchantID', isEqualTo: merchantId)
          .get();
      List<ListingItemModel> productList = snapshot.docs
          .map((doc) => ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((product) => product.expiringOn!.isBefore(now)) // Filter out expired products
          .toList();
      return productList;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> updateProduct(CatalogItemModel updatedProduct) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('CatalogItems')
          .where('productID', isEqualTo: updatedProduct.productId)
          .get();

      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance.collection('ActiveProductList')
          .where('productId', isEqualTo: updatedProduct.productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        await FirebaseFirestore.instance.collection('CatalogItems').doc(doc.id).update({
          'productName': updatedProduct.productName,
          'brand': updatedProduct.brandName,
          'basePrice': updatedProduct.basePrice,
          'itemDescription': updatedProduct.itemDescription,
          'itemImage': updatedProduct.itemImage,
        });
      } else {
        throw Exception('Product not found');
      }

      if (querySnapshot2.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot2.docs.first;
        await FirebaseFirestore.instance.collection('ActiveProductList').doc(doc.id).update({
          'productName': updatedProduct.productName,
          'brand': updatedProduct.brandName,
          'basePrice': updatedProduct.basePrice,
        });
      } else {
        throw Exception('Product not found');
      }

    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<List<CatalogItemModel>> fetchCatalogItems(String merchantId) async {
    try {
      //only fetching validated stores.
      QuerySnapshot snapshot =
          await _firestore.collection('CatalogItems').where('merchantID', isEqualTo: merchantId).get();
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
      rethrow;
    }
    return [];
  }

  Future<List<CatalogItemModel>> addListingCatalog(CatalogItemModel listing) async {
    try {
      await _firestore.collection('CatalogItems').add(listing.toJson());
    } catch (e) {
      print('Error adding listing: $e');
      rethrow;
    }
    return [];
  }

  Future<CatalogItemModel?> fetchItemById(String id) async {
    try {
      //only fetching validated stores.
      DocumentSnapshot doc = await _firestore.collection('CatalogItems').doc(id).get();
      if (doc.exists) {
        CatalogItemModel product = CatalogItemModel.fromMap(doc.data() as Map<String, dynamic>);
        // print("product in c: " + product.productName);
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
      final now = DateTime.now();
      //only fetching validated stores.
      QuerySnapshot snapshot =
      await _firestore.collection('ActiveProductList').where('merchantID', isEqualTo: id).get();
      // List<ListingItemModel> productList = snapshot.docs
      //     .map((doc) =>
      //     ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
      //     .toList();

      List<ListingItemModel> productList = snapshot.docs
          .map((doc) => ListingItemModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((product) => product.expiringOn!.isAfter(now)) // Filter out expired products
          .toList();

      return productList;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // First, get the documents matching the productId
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('ActiveProductList')
          .where('productId', isEqualTo: productId)
          .get();

      // Then delete each document
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  Future<void> deleteCatalogProduct(String productId) async {
    try {
      // First, get the documents matching the productId
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('CatalogItems')
          .where('productID', isEqualTo: productId)
          .get();

      // Then delete each document
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('CatalogItems')
  //         .doc(productId)
  //         .delete();
  //   } catch (e) {
  //     throw Exception('Error deleting product: $e');
  //   }
  // }


}
