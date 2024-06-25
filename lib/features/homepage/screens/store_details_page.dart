import 'package:flutter/material.dart';

class StoreDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Page'),
      ),
      body: Center(
        child: Text(
          'Store detail page here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
