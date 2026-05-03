import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'categories_screen.dart';
import 'product_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    children: [
                      const Icon(Icons.menu, color: Colors.black),
                      const Expanded(
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
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                Icons.shopping_cart_outlined,
                                size: 28,
                                color: Colors.black,
                              ),
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Colors.black54),
                        SizedBox(width: 8),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'All Products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Bags',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CategoriesScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'May error sa pagkuha ng products.\n${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'Wala pang products.',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  final products = snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 22,
                        mainAxisSpacing: 18,
                        childAspectRatio: 0.62,
                      ),
                      itemBuilder: (context, index) {
                        final item =
                            products[index].data() as Map<String, dynamic>;

                        final String name =
                            item['name']?.toString() ?? 'No Name';
                        final String image = item['image']?.toString() ?? '';
                        final String price = item['price']?.toString() ?? '0';
                        final String stock = item['stock']?.toString() ?? '0';
                        final String description =
                            item['description']?.toString() ??
                                'Luxury LV product';

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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: image.isNotEmpty
                                      ? Image.asset(
                                          image,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Text(
                                              'Image not found',
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            );
                                          },
                                        )
                                      : const Text(
                                          'No image',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₱$price',
                                style: const TextStyle(
                                  fontSize: 18,
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