import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class MerchantCatalogue extends StatefulWidget {
  const MerchantCatalogue({super.key});

  @override
  State<MerchantCatalogue> createState() => _MerchantCatalogueState();
}

class _MerchantCatalogueState extends State<MerchantCatalogue> {
  List<Item> items = [
    Item('Milk', '\$2.49', 0, 2.25, 3),
    Item('Bread', '\$2.99', 0, 2.75, 2),
    Item('Milk Powder', '\$3.49', 0, 3.25, 1),
    Item('Frozen Pizza', '\$6.49', 0, 6.00, 5),
    Item('Energy Drink', '\$7.00', 0, 6.50, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primaryBtn,
        title: Text('Hi, Circle K', style: TextStyle(fontFamily: "Poppins")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Catalogue',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: items.map<Widget>((Item item) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: CustomExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                        ),
                        Text(
                          item.price,
                          style: const TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Days Until Expiry: ${item.daysUntilExpiry} Days',
                                style: const TextStyle(fontFamily: "Poppins")),
                            Text('Base Price: \$${item.basePrice}',
                                style: const TextStyle(fontFamily: "Poppins")),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Automatic Price Reduction:',
                                    style: TextStyle(fontFamily: "Poppins")),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Switch(
                                    value: item.autoPriceReduction,
                                    activeColor: TColors.primaryBtn,
                                    onChanged: (bool value) {
                                      setState(() {
                                        item.autoPriceReduction = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            if (item.autoPriceReduction) ...[
                              Text(
                                  '30% Reduction: ${item.daysUntilExpiry30} Days',
                                  style: const TextStyle(fontFamily: "Poppins")),
                              Text(
                                  '50% Reduction: ${item.daysUntilExpiry50} Days',
                                  style: const TextStyle(fontFamily: "Poppins")),
                            ],
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity: ',
                                    style: TextStyle(fontFamily: "Poppins")),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (item.quantity > 0)
                                                item.quantity--;
                                            });
                                          },
                                        ),
                                        Text('${item.quantity}',
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              item.quantity++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: TColors.primaryBtn,
                                  ),
                                  child: const Text('Add To Listing',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white)),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Edit Product',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.grey)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.flash_on),
      //       label: 'Active',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag),
      //       label: 'Sales',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Catalogue',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: 2, // Set the default selected item to 'Catalogue'
      //   selectedItemColor: Colors.green,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: TColors.primaryBtn,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class Item {
  Item(
    this.name,
    this.price,
    this.daysUntilExpiry,
    this.basePrice,
    this.quantity, {
    this.isExpanded = false,
    this.autoPriceReduction = false,
  });

  String name;
  String price;
  int daysUntilExpiry;
  double basePrice;
  int quantity;
  bool isExpanded;
  bool autoPriceReduction;
  int daysUntilExpiry30 = 0;
  int daysUntilExpiry50 = 0;
}

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  CustomExpansionTile({required this.title, required this.children});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: widget.title,
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Column(
            children: widget.children,
          ),
      ],
    );
  }
}
