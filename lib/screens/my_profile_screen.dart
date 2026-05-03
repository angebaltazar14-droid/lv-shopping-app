import 'package:flutter/material.dart';
import 'package:lv/screens/categories_screen.dart';
import 'package:lv/screens/profile_screen.dart';
import 'package:lv/screens/cart_screen.dart';
import 'package:lv/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // COMPLETE PRODUCT LIST
  final List<Map<String, String>> products = [
    {'name': 'LOUIS VUITTON', 'price': '₱8,000', 'image': 'assets/bag1.png'},
    {'name': 'LOUIS VUITTON', 'price': '₱11,000', 'image': 'assets/bag2.png'},
    {'name': 'LOUIS VUITTON', 'price': '₱89,000', 'image': 'assets/bag3.png'},
    {'name': 'LOUIS VUITTON', 'price': '₱19,000', 'image': 'assets/bag4.png'},
    {'name': 'LOUIS VUITTON', 'price': '₱16,000', 'image': 'assets/bag5.png'},
    {'name': 'LOUIS VUITTON', 'price': '₱14,000', 'image': 'assets/bag6.png'},
    {'name': 'CHERRY', 'price': '₱19,000', 'image': 'assets/bag7.png'},
    {'name': 'MOZZARELLA', 'price': '₱9,000', 'image': 'assets/bag8.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSearchBar(),
            _buildCategoryTabs(),
            const SizedBox(height: 8),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ------------------ TOP BAR ------------------
  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFFE3C3A0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),

          const Text(
            'LUXURY LV',
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(radius: 6, backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------ SEARCH BAR ------------------
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      color: const Color(0xFFE3C3A0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  // ------------------ CATEGORY TABS ------------------
  Widget _buildCategoryTabs() {
    return Container(
      color: const Color(0xFFD2AC67),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          const _CategoryChip(text: 'All Products', isSelected: true),
          const SizedBox(width: 12),
          const _CategoryChip(text: 'Bags', isSelected: false),
          const SizedBox(width: 12),

          // 👉 GO TO CATEGORIES SCREEN
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
              );
            },
            child: const _CategoryChip(text: 'Categories', isSelected: false),
          ),
        ],
      ),
    );
  }

  // ------------------ PRODUCT GRID ------------------
  Widget _buildProductGrid() {
    final searchText = _searchController.text.toLowerCase();

    final filtered = products.where((p) {
      final name = p['name']!.toLowerCase();
      final price = p['price']!.toLowerCase();
      return name.contains(searchText) || price.contains(searchText);
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        itemCount: filtered.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,     // ✅ FIXED HERE!
        ),
        itemBuilder: (context, index) {
          final product = filtered[index];
          return _ProductCard(
            name: product['name']!,
            price: product['price']!,
            image: product['image']!,
          );
        },
      ),
    );
  }

  // ------------------ BOTTOM NAV ------------------
  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 0) {
            // Already at home
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

// ------------------ CATEGORY CHIP ------------------
class _CategoryChip extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _CategoryChip({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Colors.black : Colors.black54,
        fontSize: 15,
      ),
    );
  }
}

// ------------------ PRODUCT CARD ------------------
class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5E3C3),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Center(child: Image.asset(image, fit: BoxFit.contain))),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
