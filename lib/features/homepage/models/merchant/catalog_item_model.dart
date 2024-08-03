class CatalogItemModel {
  String merchantId;
  String productId;
  String productName;
  String brandName;
  double basePrice;
  String itemDescription;
  String itemImage;
  int quantity;
  double price;
  DateTime? expiringOn;
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
    this.expiringOn,
    this.itemCreatedOn,
    this.itemLastModified,
    this.quantity = 0,
    this.price = 0,
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) {
    return CatalogItemModel(
      merchantId: json['merchantID'],
      productId: json['productID'],
      productName: json['productName'],
      brandName: json['brand'],
      basePrice: json['basePrice'],
      itemDescription: json['itemDescription'],
      itemImage: json['itemImage'],
      expiringOn: json['expiringOn'] != null
          ? DateTime.parse(json['expiringOn'])
          : null,
      itemCreatedOn: json['itemCreatedOn'] != null
          ? DateTime.parse(json['itemCreatedOn'])
          : null,
      itemLastModified: json['itemLastModified'] != null
          ? DateTime.parse(json['itemLastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'merchantID': merchantId,
      'productID': productId,
      'productName': productName,
      'brand': brandName,
      'basePrice': basePrice,
      'itemDescription': itemDescription,
      'itemImage': itemImage,
      'expiringOn': expiringOn?.toIso8601String(),
      'itemCreatedOn': itemCreatedOn?.toIso8601String(),
      'itemLastModified': itemLastModified?.toIso8601String(),
    };
  }

  factory CatalogItemModel.fromMap(Map<String, dynamic> data) {
    return CatalogItemModel(
      productId: data['productID'] ?? '',
      merchantId: data['merchantID'] ?? '',
      productName: data['productName'] ?? '',
      brandName: data['brand'] ?? '',
      basePrice: (data['basePrice'] ?? 0.0).toDouble(),
      itemDescription: data['itemDescription'] ?? '',
      itemImage: data['itemImage'] ?? '',
      expiringOn: data['expiringOn'] != null
          ? DateTime.parse(data['expiringOn'])
          : null,
      itemCreatedOn: data['itemCreatedOn'] != null
          ? DateTime.parse(data['itemCreatedOn'])
          : null,
      itemLastModified: data['itemLastModified'] != null
          ? DateTime.parse(data['itemLastModified'])
          : null,
    );
  }

  List<String> validate() {
    List<String> errors = [];
    if (merchantId.isEmpty) errors.add('Merchant ID is empty');
    if (productId.isEmpty) errors.add('Product ID is empty');
    if (productName.isEmpty) errors.add('Product name is empty');
    if (brandName.isEmpty) errors.add('Brand name is empty');
    if (basePrice <= 0) errors.add('Base price must be greater than 0');
    if (itemDescription.isEmpty) errors.add('Item description is empty');
    // if (expiringOn == null) errors.add('Expiry date is not set');
    // if (itemImage.isEmpty) errors.add('Item image is empty');
    // if (quantity < 0) errors.add('Quantity cannot be negative');
    // if (price < 0) errors.add('Price cannot be negative');
    return errors;
  }

  bool isBlank() {
    return validate().isNotEmpty;
  }
}
