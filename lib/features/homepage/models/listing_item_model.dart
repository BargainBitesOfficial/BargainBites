class ListingItemModel {
  String listingId;
  String merchantId;
  String catalogId;
  String productId;

  String productName;
  String brandName;
  double basePrice;
  double price;
  int quantity;

  // int daysUntilExpiry;

  DateTime? expiringOn;

  DateTime? createdOn;
  DateTime? lastModified;

  ListingItemModel({
    this.listingId = "",
    this.merchantId = "",
    this.catalogId = "",
    this.productId = "",
    required this.productName,
    required this.brandName,
    required this.basePrice,
    required this.price,
    required this.quantity,
    required this.expiringOn,
    // required this.daysUntilExpiry,
    this.createdOn,
    this.lastModified,
  });

  factory ListingItemModel.fromMap(Map<String, dynamic> data) {
    return ListingItemModel(
      listingId: data['listingId'] ?? '',
      merchantId: data['merchantID'] ?? '',
      catalogId: data['catalogId'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      brandName: data['brand'] ?? '',
      basePrice: (data['basePrice'] ?? 0.0).toDouble(),
      price: (data['price'] ?? 0.0).toDouble(),
      quantity: data['quantity'] ?? 0,
      expiringOn:
          data['expiringOn'] != null ? DateTime.parse(data['expiringOn']) : DateTime.now(),
      //daysUntilExpiry: data['daysUntilExpiry'] ?? '',
      // daysUntilExpiry: int.tryParse(data['daysUntilExpiry']?.toString() ?? '0') ?? 0,
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
      merchantId: json['merchantID'] ?? '',
      catalogId: json['catalogId'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      brandName: json['brand'] ?? '',
      basePrice: (json['basePrice'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      expiringOn:
          json['expiringOn'] != null ? DateTime.parse(json['expiringOn']) : null,
      // daysUntilExpiry: json['daysUntilExpiry'] ?? 0,
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
      'merchantID': merchantId,
      'catalogId': catalogId,
      'productId': productId,
      'productName': productName,
      'brand': brandName,
      'basePrice': basePrice,
      'price': price,
      'quantity': quantity,
      'expiringOn': expiringOn?.toIso8601String(),
      // 'daysUntilExpiry': daysUntilExpiry,
      'createdOn': createdOn?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),
    };
  }

  List<String> validate() {
    List<String> errors = [];
    if (productName.isEmpty) errors.add('Product name is empty');
    if (brandName.isEmpty) errors.add('Brand name is empty');
    if (basePrice <= 0) errors.add('Base price must be greater than 0');
    if (price <= 0) errors.add('Price must be greater than 0');
    if (quantity <= 0) errors.add('Quantity must be greater than 0');
    if (expiringOn == null) errors.add('Expiry date is not set');
    return errors;
  }

  bool isBlank() {
    return validate().isNotEmpty;
  }
}
