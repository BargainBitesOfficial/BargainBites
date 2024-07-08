class ListingItemModel {
  String listingId;
  String merchantId;
  String catalogId;

  String productName;
  String brandName;
  double basePrice;
  double price;
  int quantity;
  int daysUntilExpiry;

  DateTime? createdOn;
  DateTime? lastModified;

  ListingItemModel({
    this.listingId = "",
    this.merchantId = "",
    this.catalogId = "",
    required this.productName,
    required this.brandName,
    required this.basePrice,
    required this.price,
    required this.quantity,
    required this.daysUntilExpiry,
    this.createdOn,
    this.lastModified,
  });

  factory ListingItemModel.fromMap(Map<String, dynamic> data) {
    return ListingItemModel(
      listingId: data['listingId'] ?? '',
      merchantId: data['merchantId'] ?? '',
      catalogId: data['catalogId'] ?? '',
      productName: data['productName'] ?? '',
      brandName: data['brandName'] ?? '',
      basePrice: (data['basePrice'] ?? 0.0).toDouble(),
      price: (data['price'] ?? 0.0).toDouble(),
      quantity: data['quantity'] ?? 0,
      daysUntilExpiry: data['daysUntilExpiry'] ?? '',
      createdOn:
          data['createdOn'] != null ? DateTime.parse(data['createdOn']) : null,
      lastModified: data['lastModified'] != null
          ? DateTime.parse(data['lastModified'])
          : null,
    );
  }

  factory ListingItemModel.fromJson(Map<String, dynamic> json) {
    return ListingItemModel(
      listingId: json['listingId'] ?? '',
      merchantId: json['merchantId'] ?? '',
      catalogId: json['catalogId'] ?? '',
      productName: json['productName'] ?? '',
      brandName: json['brandName'] ?? '',
      basePrice: (json['basePrice'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      daysUntilExpiry: json['daysUntilExpiry'] ?? 0,
      createdOn:
          json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null,
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listingId': listingId,
      'merchantId': merchantId,
      'catalogId': catalogId,
      'productName': productName,
      'brandName': brandName,
      'basePrice': basePrice,
      'price': price,
      'quantity': quantity,
      'daysUntilExpiry': daysUntilExpiry,
      'createdOn': createdOn?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
    };
  }
}
