import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bargainbites/utils/constants/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // GoogleMapController? _mapController;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.7749, -122.4194), // Replace with your desired coordinates
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Checkout',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF), // Light grey color
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Pick Up Details',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xFF757575), // Grey text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              Container(
                height: 150,
                color: Colors.grey[300],
                child: GoogleMap(
                  initialCameraPosition: _initialPosition,
                  onMapCreated: (GoogleMapController controller) {
                    // _mapController = controller;
                  },
                  markers: {
                    const Marker(
                      markerId: MarkerId('locationMarker'),
                      position: LatLng(37.7749,
                          -122.4194), // Replace with your marker position
                    ),
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Subway - Area',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
              ),
              const Text(
                style: TextStyle(fontFamily: "Poppins"),
                  'W2HM+476. Off: Shahrah e Suri. Nazimabad Street nmaaaaaa'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Handle edit payment method
                    },
                  ),
                ],
              ),
              const Row(
                children: [
                  // SvgPicture.asset(
                  //   'assets/mastercard.svg', // Make sure you have the correct path to your SVG file
                  //   height: 24,
                  //   width: 24,
                  // ),
                  SizedBox(width: 8),
                  Text(
                    'Mastercard',
                    style: TextStyle(fontSize: 18, fontFamily: "Poppins"),
                  ),
                  Spacer(),
                  Text(
                    '\$20.5',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                  ),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '**** **** 1234',
                    style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                  )),
              const SizedBox(height: 16),
              // const Divider(),
              const SizedBox(height: 8),
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1x Belgian Waffles', style: TextStyle(fontFamily: "Poppins")),
                  Text('\$28.9', style: TextStyle(fontFamily: "Poppins")),
                ],
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: TextStyle(fontFamily: "Poppins")),
                  Text('\$28.9', style: TextStyle(fontFamily: "Poppins")),
                ],
              ),
              // const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fee', style: TextStyle(fontFamily: "Poppins")),
                  Text('\$28.9', style: TextStyle(fontFamily: "Poppins")),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // LoginController.signUserIn();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primaryBtn,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: BorderSide.none),
                  child: const Text("Place Order", style: TextStyle(fontFamily: 'Poppins', color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
