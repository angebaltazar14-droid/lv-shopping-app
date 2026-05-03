import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail.dart';

class BackpackPage extends StatelessWidget {
  final Product product;

  const BackpackPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2AC67),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/bg_pattern.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: const Color(0xFFD2AC67));
                      },
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      product.image,
                      width: 170,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image not found');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              product.price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Detailed description of the backpack. Prototype content only.',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              name: product.name,
                              image: product.image,
                              price: product.price.replaceAll('₱', ''),
                              stock: '10',
                              description:
                                  'Detailed description of the backpack. Prototype content only.',
                            ),
                          ),
                        );
                      },
                      child: const Text('Buy now'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Add to cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}