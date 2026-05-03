import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'backpacks_screen.dart';
import 'slingbags_screen.dart';
import 'men_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String selectedTab = "Women";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2B074),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CATEGORIES",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // TABS
              Row(
                children: [
                  _buildTab("Women"),
                  const SizedBox(width: 10),
                  _buildTab(
                    "Men",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MenScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // RED BAG BUTTON
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "BAGS",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // CATEGORY ITEMS
              _buildCategoryItem("BAGS PACK", "assets/bagpack.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BackpacksScreen(),
                  ),
                );
              }),

              const SizedBox(height: 25),

              _buildCategoryItem("SLING BAG", "assets/slingbag.png", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SlingBagsScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // TAB BUTTON
  Widget _buildTab(String label, {VoidCallback? onTap}) {
    final bool active = selectedTab == label;

    return GestureDetector(
      onTap: onTap ??
          () {
            setState(() {
              selectedTab = label;
            });
          },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }

  // CATEGORY ITEM WITH ON TAP
  Widget _buildCategoryItem(
    String label,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}