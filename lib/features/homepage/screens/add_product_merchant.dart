import 'package:bargainbites/features/homepage/models/merchant/catalog_item_model.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../controllers/product_controller.dart';

class AddProductPage extends StatefulWidget {
  final String storeName, merchantID;

  const AddProductPage({super.key, required this.storeName, required this.merchantID});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _basePriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  Future<String?> _uploadImage(File file) async {
    try {
      // Create a unique file name for the image
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      // Get a reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child('ProductImages/$fileName');
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      // Get the download URL of the uploaded image
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Upload image to Firebase Storage and get the download URL
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImage(_imageFile!);
      }

      final ProductController productController = ProductController();
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('CatalogItems').doc();
      String id = docRef.id;
      final price = double.tryParse(_basePriceController.text) ?? 0.0;
      CatalogItemModel newListingCatalog = CatalogItemModel(
          merchantId: widget.merchantID,
          productId: id,
          productName: _productNameController.text,
          brandName: _brandNameController.text,
          basePrice: price,
          itemDescription: _descriptionController.text,
          itemImage: imageUrl ?? "");
      // itemImage: _imageFile?.path,

      List<String> errors = newListingCatalog.validate();

      if (errors.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Listing contains invalid data',
                  style: TextStyle(fontFamily: "Poppins")),
              backgroundColor: TColors.primary),
        );
        for (String error in errors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(error, style: const TextStyle(fontFamily: "Poppins")),
                backgroundColor: TColors.primary),
          );
        }
      } else {
        await productController.addListingCatalog(newListingCatalog);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Listing added successfully',
                  style: TextStyle(fontFamily: "Poppins")),
              backgroundColor: TColors.primary),
        );
        Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => MerchantCatalogue()),
        //       (Route<dynamic> route) => false,
        // );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error adding listing: $e',
                style: const TextStyle(fontFamily: "Poppins")),
            backgroundColor: TColors.primary),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryBtn,
        title: Text(widget.storeName,
            style: const TextStyle(fontFamily: "Poppins")),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add Product',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          )),
                      const SizedBox(height: 16),

                      // Product Name
                      const Text(
                        'Product Name*',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _productNameController,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a product name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Brand Name
                      const Text(
                        'Brand Name*',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _brandNameController,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a brand name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Base Price
                      const Text(
                        'Base Price*',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _basePriceController,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a base price';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Description
                      const Text(
                        'Description*',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Image Picker
                      const Text('Image', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _imageFile == null
                              ? const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined,
                                          size: 50),
                                      Text(
                                          "Choose a file or drag & drop it here"),
                                      Text("JPEG and PNG up to 5MB"),
                                    ],
                                  ),
                                )
                              : Image.file(_imageFile!, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Add Product Button
                      Center(
                        child: ElevatedButton(
                          onPressed: _addProduct,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primaryBtn,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15)),
                          child: const Text('Add Product',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 16)),
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
