import 'package:bargainbites/features/homepage/models/listing_item_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ProductDetailsPage extends StatefulWidget {
  final ListingItemModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/tomato.png', // Replace with your image asset path
              height: 300,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Quantity ${widget.product.quantity} Kg',
                      style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Poppins"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '\$${widget.product.price}',
                      style: TextStyle(fontSize: 24, color: Colors.green, fontFamily: "Poppins"),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    //   decoration: BoxDecoration(
                    //     color: Colors.redAccent,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   // child: Text(
                    //   //   '50% OFF',
                    //   //   style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "Poppins"),
                    //   // ),
                    // ),
                  ],
                ),
              ],
            ),
          ),


          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
            child: Text(
              'Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia Amet minim mollit non deserunt ullamco',
              style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: "Poppins"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: InkWell(
              onTap: () {
                // Handle "See More Detail" tap
              },
              child: const Text(
                'See More Detail',
                style: TextStyle(fontSize: 14, color: TColors.primary, fontFamily: "Poppins"),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Handle "Add to Cart" button press
                },
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Poppins"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
