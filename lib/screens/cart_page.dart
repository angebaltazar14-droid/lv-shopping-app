import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    // prototype cart (static)
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      appBar: AppBar(backgroundColor: const Color(0xFFD2AC67), elevation: 0, iconTheme: const IconThemeData(color: Colors.black), title: const Text('Cart', style: TextStyle(color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(color: const Color(0xFFF5E3C3), borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(width: 64, height: 64, color: Colors.white, child: const Icon(Icons.image)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Item ${index+1}', style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height:4), const Text('₱9,000')])),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outline))
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Checkout (prototype)')));
                },
                child: const Text('Checkout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
