import 'package:flutter/material.dart';

class MerchantModel {
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
  String streetAddress;
  String postalCode;

  //Map<String, TimeOfDay> storeTiming = new Map<String, TimeOfDay>();

  bool isValidated;
  bool isOpened;

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
    required this.streetAddress,
    required this.postalCode,

    //this.storeTiming = {},

    this.isValidated = false,
    this.isOpened = false
  });

  Map<String, dynamic> toJson() {
    return {
      'merchantName': merchantName,
      'merchantContact': merchantContact,
      'merchantEmail': merchantEmail,
      'password': password,

      'storeName': storeName,
      'storeId': storeId,
      'storeContact': storeContact,

      'country': country,
      'province': province,
      'streetAddress': streetAddress,
      'postalCode': postalCode,

      'isValidated': isValidated
    };
  }
}
