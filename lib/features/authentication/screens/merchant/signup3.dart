import 'package:bargainbites/features/homepage/screens/explore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants/colors.dart';
import '../../controllers/user/signup_controller.dart';
import '../user/signup.dart';

class MerchantAddressPage extends StatefulWidget {
  const MerchantAddressPage({super.key});

  @override
  _MerchantAddressPageState createState() => _MerchantAddressPageState();
}

class _MerchantAddressPageState extends State<MerchantAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _selectedProvince;
  final List<String> _provinces = ['Ontario', 'Quebec', 'British Columbia', 'Alberta'];

  String emptyStrError = "This field cannot be empty";
  @override
  void dispose() {
    _cityController.dispose();
    _streetAddressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState?.validate() ?? false) {
      // Proceed to next step
    }
  }

  String? _validateAlphanumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
      return 'Only alphanumeric characters are allowed';
    }
    return null;
  }

  String? _validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Only alphanumeric characters are allowed';
    } else if (value.length != 6) {
      return 'Postal code must be 6 characters long';
    }
    return null;
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
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2 ),
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            //controller: controller.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(236, 236, 236, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return controller.validateName()
                                  ? null
                                  : "Name must be longer than 4 characters";
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
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // PROVINCE
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2 ),
                    child: Text(
                      'Province*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ),
                DropdownButtonFormField<String>(
                  value: _selectedProvince,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(236, 236, 236, 1),
                  ),
                  items: _provinces
                      .map((province) => DropdownMenuItem(
                    value: province,
                    child: Text(province),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a province' : null,
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
                    )
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            //controller: controller.cityController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(236, 236, 236, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return controller.validateName()
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
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 2 ),
                      child: Text(
                        'Street Address*',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            //controller: controller.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(236, 236, 236, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return controller.validateName()
                                  ? null
                                  : emptyStrError;
                            },
                            keyboardType: TextInputType.text,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 2 ),
                    child: Text(
                      'Postal Code*',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            //controller: controller.nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(236, 236, 236, 1),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return controller.validateName()
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
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your login functionality here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExplorePage()),
                      );
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

