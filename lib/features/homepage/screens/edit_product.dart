import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/features/homepage/controllers/product_controller.dart';
import 'package:bargainbites/features/homepage/models/merchant/catalog_item_model.dart';

class EditProductPage extends StatefulWidget {
  final CatalogItemModel item;

  const EditProductPage({super.key, required this.item});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _basePriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing product data
    _productNameController.text = widget.item.productName;
    _brandNameController.text = widget.item.brandName;
    _basePriceController.text = widget.item.basePrice.toString();
    _descriptionController.text = widget.item.itemDescription;
  }

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
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference storageReference =
      FirebaseStorage.instance.ref().child('ProductImages/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _editProduct() async {
    // if (_formKey.currentState?.validate() != true) {
    //   return;
    // }

    setState(() {
      _isLoading = true;
    });

    try {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImage(_imageFile!);
      }

      final ProductController productController = ProductController();
      final price = double.tryParse(_basePriceController.text) ?? 0.0;
      CatalogItemModel updatedProduct = CatalogItemModel(
          merchantId: widget.item.merchantId,
          productId: widget.item.productId,
          productName: _productNameController.text,
          brandName: _brandNameController.text,
          basePrice: price,
          itemDescription: _descriptionController.text,
          itemImage: imageUrl ?? widget.item.itemImage);

      List<String> errors = updatedProduct.validate();

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
        await productController.updateProduct(updatedProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Product updated successfully',
                  style: TextStyle(fontFamily: "Poppins")),
              backgroundColor: TColors.primary),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error updating product: $e',
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
        title: const Text('Edit Product',
            style: TextStyle(fontFamily: "Poppins")),
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
                const Text('Edit Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    )),
                const SizedBox(height: 16),

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
                      hintText: widget.item.productName,
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
                      hintText: widget.item.brandName,
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
                      hintText: widget.item.basePrice.toString(),
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
                      hintText: widget.item.itemDescription,
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
                        ? widget.item.itemImage.isEmpty
                        ? const Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined,
                              size: 50),
                          Text(
                              "Choose a file or drag & drop it here"),
                          Text("JPEG and PNG up to 5MB"),
                        ],
                      ),
                    )
                        : Image.network(widget.item.itemImage,
                        fit: BoxFit.cover)
                        : Image.file(_imageFile!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: _editProduct,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primaryBtn,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15)),
                    child: const Text('Update Product',
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
