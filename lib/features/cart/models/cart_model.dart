import 'package:bargainbites/features/homepage/models/listing_item_model.dart';

class CartModel {
  final String cartId;
  final String merchantId;
  final String merchantName;
  final String merchantAddress;
  final String userId;
  final List<ListingItemModel> items;
  double total;

  CartModel({
    required this.cartId,
    required this.merchantId,
    required this.merchantName,
    required this.merchantAddress,
    required this.userId,
    required this.items,
    required this.total,
  });

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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'merchantId': merchantId,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
    };
  }

  void updateTotal() {
    total = items.fold(0.0, (sum, item) => sum + item.price);
  }
}
