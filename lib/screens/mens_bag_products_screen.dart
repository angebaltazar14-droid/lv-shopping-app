import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../data/cart.dart';
import 'cart_screen.dart';

class MensBagProductsScreen extends StatelessWidget {
  const MensBagProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {"image": "assets/mens_bag1.png", "name": "LV Bag 1", "price": 8000},
      {"image": "assets/mens_bag2.png", "name": "LV Bag 2", "price": 9000},
      {"image": "assets/mens_bag3.png", "name": "LV Bag 3", "price": 10000},
      {"image": "assets/mens_bag4.png", "name": "LV Bag 4", "price": 11000},
      {"image": "assets/mens_bag5.png", "name": "LV Bag 5", "price": 12000},
      {"image": "assets/mens_bag6.png", "name": "LV Bag 6", "price": 13000},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Men's Bag",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = products[index];

                  return GestureDetector(
                    onTap: () {
                      addToCart(
                        name: item["name"].toString(),
                        price: item["price"].toString(),
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
                          Text("₱${item["price"]}"),
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