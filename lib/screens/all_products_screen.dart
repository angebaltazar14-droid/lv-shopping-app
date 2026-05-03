import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/bottom_nav.dart';
import 'categories_screen.dart';
import 'product_detail.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  String formatPrice(dynamic price) {
    if (price == null) return "0";
    return price.toString();
  }

  Widget productImage(String image) {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text("Image not found"));
        },
      );
    }

    return Image.asset(
      image,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text("Image not found"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              color: const Color(0xFFD9C3A3),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.menu, color: Colors.black),
                      Expanded(
                        child: Center(
                          child: Text(
                            "LUXURY LV",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.notifications_none, color: Colors.black),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black54),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, size: 18),
                              SizedBox(width: 8),
                              Text("Search"),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.shopping_cart_outlined, size: 30),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "All Products",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Bags",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CategoriesScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Categories",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error loading products"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!.docs;

                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products yet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final data =
                            products[index].data() as Map<String, dynamic>;

                        final name = data['name']?.toString() ?? '';
                        final image = data['image']?.toString() ?? '';
                        final price = formatPrice(data['price']);
                        final stock = data['stock']?.toString() ?? '0';
                        final description =
                            data['description']?.toString() ?? '';

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                  name: name,
                                  image: image,
                                  price: price,
                                  stock: stock,
                                  description: description,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: productImage(image),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "₱$price",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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