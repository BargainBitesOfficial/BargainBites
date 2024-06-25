import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bargainbites/features/authentication/models/merchant_model.dart';

class ExploreController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MerchantModel>> fetchMerchants() async {
    try {
      //only fetching validated stores.
      QuerySnapshot snapshot = await _firestore.collection('Merchants').where('isValidated', isEqualTo: true).get();
      List<MerchantModel> merchantList = snapshot.docs.map((doc) => MerchantModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
      return merchantList;
    } catch (e) {
      print('Error fetching merchants: $e');
      return [];
    }
  }

  Future<double> getDistanceByRoad(String sourcePostalCode, String destinationPostalCode, String apiKey) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json'
            '?origins=$sourcePostalCode'
            '&destinations=$destinationPostalCode'
            '&key=$apiKey'
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['rows'].isNotEmpty) {
        final elements = data['rows'][0]['elements'];
        if (elements.isNotEmpty && elements[0]['status'] == 'OK') {
          final distance = elements[0]['distance']['value']; // distance in meters
          return distance / 1000; // convert to kilometers
        }
        else {
          print("distance not okay");
        }
      }
      else {
        print("no rows");
      }
    }
    else {
      print('Error fetching distance: ${response.statusCode}');
    }
    return -1.0; // Return null if no valid distance found
  }
}
