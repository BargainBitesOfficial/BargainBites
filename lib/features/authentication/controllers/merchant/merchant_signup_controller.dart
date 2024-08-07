import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/merchant_model.dart';
import '../../screens/user/signup_address.dart';

class MerchantSignupController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final storeNameController = TextEditingController();
  final storeIdController = TextEditingController();
  final storeNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cityController = TextEditingController();
  final streetAddressController = TextEditingController();
  final postalCodeController = TextEditingController();

  String? selectedProvince;

  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPhoneNumberValid = false;
  bool _isStoreNameValid = false;
  bool _isStoreNumberValid = false;
  bool _isStoreIdValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isCityValid = false;
  bool _isStreetAddressValid = false;
  bool _isPostalCodeValid = false;
  bool _isProvinceValid = false;

  MerchantSignupController() {
    nameController.addListener(_validateName);
    emailController.addListener(_validateEmail);
    phoneNumberController.addListener(_validatePhoneNumber);
    storeNameController.addListener(_validateStoreName);
    storeIdController.addListener(_validateStoreId);
    storeNumberController.addListener(_validateStoreNumber);
    passwordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
    cityController.addListener(_validateCity);
    streetAddressController.addListener(_validateStreetAddress);
    postalCodeController.addListener(_validatePostalCode);
  }

  bool get isFormValid =>
      _isNameValid &&
          _isEmailValid &&
          // _isPhoneNumberValid &&
          _isStoreNameValid &&
          _isStoreNumberValid &&
          _isStoreIdValid &&
          _isPasswordValid &&
          _isConfirmPasswordValid &&
          _isCityValid &&
          _isStreetAddressValid &&
          _isPostalCodeValid &&
          _isProvinceValid;

  void _validateName() {
    _isNameValid = validateName();
    notifyListeners();
  }

  void _validateEmail() {
    _isEmailValid = validateEmail();
    notifyListeners();
  }

  void _validatePhoneNumber() {
    _isPhoneNumberValid = validatePhoneNumber();
    notifyListeners();
  }

  void _validateStoreId() {
    _isStoreIdValid = validateStoreId();
    notifyListeners();
  }

  void _validateStoreName() {
    _isStoreNameValid = validateStoreName();
    notifyListeners();
  }

  void _validateStoreNumber() {
    _isStoreNumberValid = validateStoreNumber();
    notifyListeners();
  }

  void _validatePasswords() {
    _isPasswordValid = passwordController.text.isNotEmpty;
    _isConfirmPasswordValid = validatePasswords();
    notifyListeners();
  }

  void _validateCity() {
    _isCityValid = cityController.text.isNotEmpty;
    notifyListeners();
  }

  void _validateStreetAddress() {
    _isStreetAddressValid = streetAddressController.text.isNotEmpty;
    notifyListeners();
  }

  void _validatePostalCode() {
    _isPostalCodeValid = validatePostalCode();
    notifyListeners();
  }

  bool validatePhoneNumber() {
    String phoneNumber = phoneNumberController.text;
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  bool validateStoreNumber() {
    String phoneNumber = storeNumberController.text;
    String pattern = r'^\d{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }

  bool validateStoreName() {
    String name = storeNameController.text;
    RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return name.length > 4 && nameRegex.hasMatch(name);
  }

  bool validateStoreId() {
    String storeId = storeIdController.text;
    String pattern = r'^\d{6}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(storeId);
  }

  bool validateEmail() {
    String email = emailController.text;
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  bool validateName() {
    String name = nameController.text;
    RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return name.length > 4 && nameRegex.hasMatch(name);
  }

  bool validatePasswords() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    return password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword &&
        password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool validatePostalCode() {
    String postalCode = postalCodeController.text;
    final RegExp postalCodePattern = RegExp(r'^[A-Z]\d[A-Z] ?\d[A-Z]\d$');;
    return postalCodePattern.hasMatch(postalCode) && postalCode.length == 6;
  }

  void updateProvince(String? value) {
    selectedProvince = value;
    _isProvinceValid = selectedProvince != null;
    notifyListeners();
  }

  Future<void> createUser(MerchantModel signupModel) async {
    try {
      UserCredential merchantCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signupModel.merchantEmail,
        password: signupModel.password,
      );

      await FirebaseFirestore.instance
          .collection('Merchants')
          .doc(merchantCredential.user!.uid)
          .set({
        'merchantID': signupModel.merchantID,
        'merchantName': signupModel.merchantName,
        'merchantContact': signupModel.merchantContact,
        'merchantEmail': signupModel.merchantEmail,
        'password': signupModel.password,
        'storeName': signupModel.storeName,
        'storeId': signupModel.storeId,
        'storeContact': signupModel.storeContact,
        'country': signupModel.country,
        'province': signupModel.province,
        'streetAddress': signupModel.streetAddress,
        'postalCode': signupModel.postalCode,
        'isValidated': signupModel.isValidated,
        'isStoreOpen': signupModel.isOpened
      });

      reset();
    } on FirebaseAuthException {
      // Handle error
    }
  }

  void reset() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
    storeNameController.clear();
    storeIdController.clear();
    storeNumberController.clear();
    confirmPasswordController.clear();
    cityController.clear();
    streetAddressController.clear();
    postalCodeController.clear();
    _isNameValid = false;
    _isEmailValid = false;
    _isPasswordValid = false;
    _isPhoneNumberValid = false;
    _isStoreNumberValid = false;
    _isStoreIdValid = false;
    _isStoreNameValid = false;
    _isConfirmPasswordValid = false;
    _isCityValid = false;
    _isStreetAddressValid = false;
    _isPostalCodeValid = false;
    _isProvinceValid = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    storeNameController.dispose();
    storeIdController.dispose();
    storeNumberController.dispose();
    confirmPasswordController.dispose();
    cityController.dispose();
    streetAddressController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    if (!validateName()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name must be longer than 4 characters."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!validateEmail()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email format. Please enter a valid email."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!validatePasswords()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("The passwords do not match. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupAddress(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }
}
