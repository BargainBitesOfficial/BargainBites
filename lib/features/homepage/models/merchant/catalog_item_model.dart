class CatalogItemModel {
  String merchantId;
  String productId;
  String productName;
  String brandName;
  double basePrice;
  String itemDescription;
  String itemImage;
  bool isCountable;
  int quantity;
  double price;

  DateTime? itemCreatedOn;
  DateTime? itemLastModified;

  CatalogItemModel({
    required this.merchantId,
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.basePrice,
    required this.itemDescription,
    required this.itemImage,
    required this.isCountable,
    this.itemCreatedOn,
    this.itemLastModified,
    this.quantity = 0,
    this.price = 0
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) {
    return CatalogItemModel(
      merchantId: json['merchantId'],
      productId: json['productId'],
      productName: json['productName'],
      brandName: json['brandName'],
      basePrice: json['basePrice'],
      itemDescription: json['itemDescription'],
      itemImage: json['itemImage'],
      isCountable: json['isCountable'],
      itemCreatedOn: json['itemCreatedOn'] != null ? DateTime.parse(json['itemCreatedOn']) : null,
      itemLastModified: json['itemLastModified'] != null ? DateTime.parse(json['itemLastModified']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchantId': merchantId,
      'productId': productId,
      'productName': productName,
      'brandName': brandName,
      'basePrice': basePrice,
      'itemDescription': itemDescription,
      'itemImage': itemImage,
      'isCountable': isCountable,
      'itemCreatedOn': itemCreatedOn?.toIso8601String(),
      'itemLastModified': itemLastModified?.toIso8601String(),
    };
  }

  factory CatalogItemModel.fromMap(Map<String, dynamic> data) {
    return CatalogItemModel(
      productId: data['productId'] ?? '',
      merchantId: data['merchantId'] ?? '',
      productName: data['productName'] ?? '',
      brandName: data['brandName'] ?? '',
      basePrice: (data['basePrice'] ?? 0.0).toDouble(),
      itemDescription: data['itemDescription'] ?? '',
      itemImage: data['itemImage'] ?? '',
      isCountable: data['isCountable'] ?? false,
      itemCreatedOn: data['itemCreatedOn'] != null ? DateTime.parse(data['itemCreatedOn']) : null,
      itemLastModified: data['itemLastModified'] != null
          ? DateTime.parse(data['itemLastModified'])
          : null,
    );
  }
}