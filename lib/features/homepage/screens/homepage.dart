import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
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
                          const Row(children: [
                            Text(
                              'Discover Savings',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 22,
                                  color: TColors.bWhite,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                    color: TColors.primary,
                                    // Match the background gradient
                                    onPressed: () {
                                      // Add your onPressed code here!
                                    },
                                  )))
                            ],
                          ),
                        ]),
                    const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('University Avenue Windsor, N9B 2Y8',
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.white)),
                          ]),
                          Text('within 10 km',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.white)),
                        ]),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: 45,
                                child: TextField(
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search,
                                            color: Colors.black54),
                                        filled: true,
                                        fillColor: TColors.bWhite,
                                        hintText:
                                            'Search the best discounts...',
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))))),
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                )),
          ),
        ),
        body: const SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: "What’s in the neighborhood"),
            HorizontalItemList(),
            SectionTitle(title: "Explore"),
            VerticalItemList(),
          ],
        )));
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
          TextButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //         const ForgotPassword()));
            },
            child: const Text(
              "see all",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalItemList extends StatelessWidget {
  const HorizontalItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const DiscountCard();
        },
      ),
    );
  }
}

class VerticalItemList extends StatelessWidget {
  const VerticalItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) => const DiscountCardVertical()),
    );
  }
}

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/grocery.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: const Text(
                      'new',
                      style: TextStyle(
                          color: TColors.primary,
                          fontSize: 12.0,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Subway',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
            const Text('Closes at 10 PM',
                style: TextStyle(fontFamily: "Poppins")),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16.0),
                Text('4.7', style: TextStyle(fontFamily: "Poppins")),
                SizedBox(width: 4.0),
                Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                Text('10 km', style: TextStyle(fontFamily: "Poppins")),
              ],
            ),
            const SizedBox(height: 8.0),
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   color: Colors.green[100],
            //   child: const Text(
            //     '50% OFF',
            //     style: TextStyle(
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DiscountCardVertical extends StatelessWidget {
  const DiscountCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/grocery.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 110.0,
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    child: const Text(
                      'new',
                      style: TextStyle(
                          color: TColors.primary,
                          fontSize: 12.0,
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Subway',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins"),
            ),
            const Text('Closes at 10 PM',
                style: TextStyle(fontFamily: "Poppins")),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 16.0),
                Text('4.7', style: TextStyle(fontFamily: "Poppins")),
                SizedBox(width: 4.0),
                Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                Text('10 km', style: TextStyle(fontFamily: "Poppins")),
              ],
            ),
            const SizedBox(height: 8.0),
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   color: Colors.green[100],
            //   child: const Text(
            //     '50% OFF',
            //     style: TextStyle(
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
