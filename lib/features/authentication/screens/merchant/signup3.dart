import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bargainbites/features/startup/screens/new_merchant_info.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/merchant/merchant_signup_controller.dart';
import 'package:bargainbites/features/authentication/models/merchant_model.dart';

class MerchantAddressPage extends StatefulWidget {
  final String name;
  final String personalNumber;
  final String email;
  final String password;
  final String storeId;
  final String storeNumber;
  final String storeName;

  const MerchantAddressPage({
    super.key,
    required this.name,
    required this.personalNumber,
    required this.email,
    required this.password,
    required this.storeId,
    required this.storeNumber,
    required this.storeName,
  });

  @override
  _MerchantAddressPageState createState() => _MerchantAddressPageState();
}

class _MerchantAddressPageState extends State<MerchantAddressPage> {
  final TextEditingController countryController =
  TextEditingController(text: 'Canada');
  final _formKey = GlobalKey<FormState>();
  final List<String> _provinces = [
    'Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba',
    'Saskatchewan', 'Yukon', 'Prince Edward Island', 'Nunavut',
    'Nova Scotia', 'Newfoundland and Labrador'
  ];
  String emptyStrError = "This field cannot be empty";
  late MerchantSignupController signupController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    signupController = Provider.of<MerchantSignupController>(context);
  }

  void submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (signupController.selectedProvince == null || signupController.selectedProvince!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select a province."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final merchantModel = MerchantModel(
        merchantName: widget.name,
        merchantContact: widget.personalNumber,
        merchantEmail: widget.email,
        password: widget.password,
        storeName: widget.storeName,
        storeId: widget.storeId,
        storeContact: widget.storeNumber,
        country: countryController.text,
        province: signupController.selectedProvince!,
        city:signupController.cityController.text,
        streetAddress: signupController.streetAddressController.text,
        postalCode: signupController.postalCodeController.text,
        isValidated: false,
        isStoreOpen: false,
      );

      try {
        await signupController.createUser(merchantModel);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Merchant created successfully."),
            backgroundColor: Colors.green,
          ),
        );

        signupController.reset();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NewMerchantInfo()), // Change to the appropriate login screen if needed
              (Route<dynamic> route) => false,
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to create merchant: ${e.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Merchant Account', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/signup_address.svg", // Replace with your SVG asset
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),

                // COUNTRY
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return TextFormField(
                      controller: countryController,
                      readOnly: true,// Use appropriate controller
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(236, 236, 236, 1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value?.isNotEmpty ?? false
                            ? null
                            : emptyStrError;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z]'),
                        ),
                      ],
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // PROVINCE
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                    child: Text(
                      'Province*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return DropdownButtonFormField<String>(
                      value: controller.selectedProvince,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(236, 236, 236, 1),
                      ),
                      items: _provinces.map((province) => DropdownMenuItem(
                        value: province,
                        child: Text(province),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          controller.selectedProvince = value;
                        });
                      },
                      validator: (value) => value == null ? 'Please select a province' : null,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // CITY
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                    child: Text(
                      'City*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return TextFormField(
                      controller: controller.cityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(236, 236, 236, 1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value?.isNotEmpty ?? false
                            ? null
                            : emptyStrError;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z]'),
                        ),
                      ],
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // STREET ADDRESS
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                    child: Text(
                      'Street Address*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return TextFormField(
                      controller: controller.streetAddressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(236, 236, 236, 1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return value?.isNotEmpty ?? false
                            ? null
                            : emptyStrError;
                      },
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // POSTAL CODE
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2),
                    child: Text(
                      'Postal Code*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return TextFormField(
                      controller: controller.postalCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(236, 236, 236, 1),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return controller.validatePostalCode()
                            ? null
                            : "Invalid postal code";
                      },
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Next Button
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          submit();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primaryBtn,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Next', style: TextStyle(color: Colors.white, fontSize: 16)),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
