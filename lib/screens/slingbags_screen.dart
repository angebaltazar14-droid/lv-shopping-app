import 'package:flutter/material.dart';
import '../data/cart.dart';
import 'cart_screen.dart';

class SlingBagsScreen extends StatelessWidget {
  const SlingBagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bags = [
      {"image": "assets/sling1.png", "name": "LV Sling 1", "price": 7500},
      {"image": "assets/sling2.png", "name": "LV Sling 2", "price": 8300},
      {"image": "assets/sling3.png", "name": "LV Sling 3", "price": 6200},
      {"image": "assets/sling4.png", "name": "LV Sling 4", "price": 5999},
      {"image": "assets/sling5.png", "name": "LV Sling 5", "price": 7100},
      {"image": "assets/sling6.png", "name": "LV Sling 6", "price": 4900},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Sling bags",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // PRODUCT GRID
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: bags.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = bags[index];

                  return GestureDetector(
                    onTap: () {
                      // ADD TO CART
                    addToCart(
  name: item["name"].toString(),
  price: item["price"].toString(),
  image: item["image"].toString(),
);

                      // NAVIGATE TO CART PAGE
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E3C3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              item["image"],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            item["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₱${item["price"]}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
