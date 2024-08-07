import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

class CartModel {
  final String cartId;
  final String merchantId;
  final String merchantName;
  final String merchantAddress;
  final String userId;
  List<ListingItemModel> items;
  double total;
  Map<String, int> itemQuantity;

  CartModel({
    required this.cartId,
    required this.merchantId,
    required this.merchantName,
    required this.merchantAddress,
    required this.userId,
    this.items = const [],
    this.total = 0.0,
    Map<String, int>? itemQuantity,
  }): itemQuantity = itemQuantity ?? {};

  factory CartModel.fromJson(Map<String, dynamic> json) {

    // calculating the cart total
    List<ListingItemModel> items_list = (json['items'] as List)
        .map((item) => ListingItemModel.fromJson(item))
        .toList();

    // Calculate the total based on items' prices
    double total = items_list.fold(0.0, (sum, item) => sum + item.price);

    return CartModel(
      cartId: json['cartId'],
      merchantId: json['merchantId'],
      merchantName: json['merchantName'],
      merchantAddress: json['merchantAddress'],
      userId: json['userId'],
      items: items_list,
      total: total,
      itemQuantity: Map<String, int>.from(json['itemQuantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'merchantId': merchantId,
      'merchantName': merchantName,
      'merchantAddress': merchantAddress,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'itemQuantity': itemQuantity,
    };
  }

  void updateTotal() {
    total = items.fold(0.0, (sum, item) {
      int quantity = itemQuantity[item.productId] ?? 0;
      return sum + (item.price * quantity);
    });
  }
}
