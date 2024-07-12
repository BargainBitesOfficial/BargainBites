class MerchantModel {
  String imageUrl;
  String merchantId;
  String merchantName;
  String merchantContact;
  String merchantEmail;
  String password;

  String storeName;
  int storeId;
  String storeContact;

  String country;
  String province;
  String city;
  String streetAddress;
  String postalCode;

  Map<String, Map<String, String>>? storeTiming;

  bool isValidated;
  bool isOpened;
  double currDistance; // stores distance of current merchant from user
  double merchantRating;

  MerchantModel({
    this.merchantId = "",
    required this.merchantName,
    required this.merchantContact,
    required this.merchantEmail,
    required this.password,
    required this.storeName,
    required this.storeId,
    required this.storeContact,
    required this.country,
    required this.province,
    required this.city,
    required this.streetAddress,
    required this.postalCode,
    this.storeTiming,
    this.imageUrl = "",
    this.isValidated = false,
    this.isOpened = false,
    this.currDistance = 0.0,
    this.merchantRating = 0.0,
  });

  factory MerchantModel.fromMap(Map<String, dynamic> data) {
    try {
      print('Processing merchant data: $data');
      return MerchantModel(
        imageUrl: data['imgUrl'] ?? '',
        merchantId: data['merchantId'] ?? '',
        merchantName: data['merchantName'] ?? '',
        merchantContact: data['merchantContact'] ?? '',
        merchantEmail: data['merchantEmail'] ?? '',
        password: data['password'] ?? '',
        storeName: data['storeName'] ?? '',
        storeId: data['storeId'] ?? 0,
        storeContact: data['storeContact'] ?? '',
        country: data['country'] ?? '',
        province: data['province'] ?? '',
        city: data['city'] ?? '',
        streetAddress: data['streetAddress'] ?? '',
        postalCode: data['postalCode'] ?? '',
        storeTiming: data['storeTiming'] != null
            ? (data['storeTiming'] as Map<String, dynamic>).map((key, value) =>
                MapEntry(key, Map<String, String>.from(value as Map)))
            : null,
        isValidated: data['isValidated'] ?? false,
        isOpened: data['isOpened'] ?? false,
      );
    } catch (e) {
      print('Error processing merchant data: $e');
      throw e;
    }
  }
}
