import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.home, 0, '/home'),
          _navItem(context, Icons.search, 1, '/search'),
          _navItem(context, Icons.shopping_cart, 2, '/cart'),
          _navItem(context, Icons.account_circle, 3, '/profile'),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext ctx, IconData icon, int index, String route) {
    final bool active = currentIndex == index;

    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(ctx, route),
      child: Icon(
        icon,
        size: 30,
        color: active ? Colors.black : Colors.grey,
      ),
    );
  }
}
