import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<FoodItem> items = [
    FoodItem(
      title: 'Subway',
      //imageUrl: 'https://example.com/image.jpg',
      deliveryTime: '32 min',
      deliveryFee: '\$0 delivery fee',
      rating: 4.7,
      distance: 10,
    ),
    // Add more items here
  ];

  Future<void> _refreshItems() async {
    // Simulate a network call and refresh the list
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // Update the items list
      // This is just a simulation. You should replace it with your actual data fetch logic.
      items.add(FoodItem(
        title: 'New Subway',
        //imageUrl: 'assets/images/food.jpg',
        deliveryTime: '30 min',
        deliveryFee: '\$0 delivery fee',
        rating: 4.8,
        distance: 8,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: TColors.linerGradient,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Browse',
                      style: TextStyle(
                          fontSize: 18,
                          color: TColors.bWhite,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.shopping_cart),
                              color: TColors.primary, // Match the background gradient
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0), // Add some space between the icons
                        Container(
                          height: 38,
                          width: 38,
                          decoration: const BoxDecoration(
                            color: TColors.bWhite,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(Icons.notifications),
                              color: TColors.primary, // Match the background gradient
                              onPressed: () {
                                // Add your onPressed code here!
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search, color: Colors.black54),
                            filled: true,
                            fillColor: TColors.bWhite,
                            hintText: 'Search with filters & browse',
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune, color: TColors.primary),
                        onPressed: () {
                          // Add your onPressed code here!
                        },
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 10)
              ],
            )
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // FilterChip(
                //   label: const Text('Distance'),
                //   onSelected: (bool value) {},
                // ),
                // const SizedBox(width: 8),
                // FilterChip(
                //   label: const Text('Rating'),
                //   onSelected: (bool value) {},
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    height: 28.0, // Reduced height
                    color: TColors.primary, // Background color
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Center(
                        child: Text(
                          "Distance",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    height: 28.0, // Reduced height
                    color: TColors.primary, // Background color
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Center(
                        child: Text(
                          "Rating",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                // Positioned(
                //   top: 4.0,
                //   right: 4.0,
                //   child: GestureDetector(
                //     //onTap: onDeleted,
                //     child: Container(
                //       decoration: const BoxDecoration(
                //         color: Colors.red,
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(
                //         Icons.close,
                //         size: 18.0,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          ),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Poppins'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('see all',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      fontFamily: 'Poppins'
                  ),
                ),
              )
            ],
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshItems,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // This gives the depth effect
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.asset(
                            'assets/images/grocery.jpg',
                            width: double.infinity,
                            height: 150, // Set a height for the image
                            fit: BoxFit.cover, // This makes the image expand to fill the width
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('${item.deliveryTime} • ${item
                                  .deliveryFee}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: TColors.starIconColor,
                                      size: 16),
                                  Text('${item.rating}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.location_on,
                                      color: TColors.greyText, size: 16),
                                  Text('${item.distance} km',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore,  color: TColors.primary),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag, color: TColors.bBlack,),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list,  color: TColors.bBlack),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,  color: TColors.bBlack),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
    );
  }
}


class FoodItem {
  final String title;

  //final String imageUrl;
  final String deliveryTime;
  final String deliveryFee;
  final double rating;
  final double distance;

  FoodItem({
    required this.title,
    //required this.imageUrl,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.rating,
    required this.distance,
  });
}
