import 'package:flutter/material.dart';
import '../data/cart.dart';
import 'cart_screen.dart';

class BackpacksScreen extends StatelessWidget {
  const BackpacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bags = [
      {"image": "assets/backpack1.png", "name": "LV Backpack 1", "price": 8500},
      {"image": "assets/backpack2.png", "name": "LV Backpack 2", "price": 9999},
      {"image": "assets/backpack3.png", "name": "LV Backpack 3", "price": 7500},
      {"image": "assets/backpack4.png", "name": "LV Backpack 4", "price": 6999},
      {"image": "assets/backpack5.png", "name": "LV Backpack 5", "price": 5999},
      {"image": "assets/backpack6.png", "name": "LV Backpack 6", "price": 4500},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Column(
          children: [
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
                    "Backpacks",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

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
                     addToCart(
  name: item["name"].toString(),
  price: item["price"],
  image: item["image"].toString(),
);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
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
                              item["image"].toString(),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text("Image not found"),
                                );
                              },
                            ),
                          ),
                          Text(
                            item["name"].toString(),
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