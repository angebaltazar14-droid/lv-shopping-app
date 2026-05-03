import 'package:flutter/material.dart';

// ⭐ IMPORT ALL SCREENS PROPERLY
import 'package:lv/screens/my_orders_screen.dart';
import 'package:lv/screens/shipping_address_screen.dart';
import 'package:lv/screens/payment_methods_screen.dart';
import 'package:lv/screens/cancelled_screen.dart';
import 'package:lv/screens/history_screen.dart';
import 'package:lv/screens/home_screen.dart';
import 'package:lv/screens/search_screen.dart';
import 'package:lv/screens/cart_screen.dart';

// ✅ ADD THIS
import 'package:lv/screens/seller_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My profile",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/profile.png"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Matilda Brown",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text("matildabrown@gmail.com"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _item("My orders", "I already have 12 orders", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
                );
              }),

              _item("Shipping addresses", "3 addresses", () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const ShippingAddressScreen(
        currentAddress: "6391 Elgin St. Celina, Delaware 10299, Philippines",
        currentPhone: "+91587654321",
      ),
    ),
  );
}),

              _item("Payment methods", "Visa **** 1234", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PaymentMethodsScreen(),
                  ),
                );
              }),

              _item("History", "", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              }),

              _item("Cancelled", "", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CancelledScreen()),
                );
              }),

              // ✅ INSERTED HERE (ITO YUNG KULANG MO)
              _item("Seller Details", "", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SellerDetailsScreen(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: _bottomNav(),
    );
  }

  // ⭐ Reusable List Item
  Widget _item(String title, String subtitle, VoidCallback action) {
    return InkWell(
      onTap: action,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(title, style: const TextStyle(fontSize: 17)),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          const Divider(height: 25, thickness: 1),
        ],
      ),
    );
  }

  // ⭐ Bottom Navigation Bar
  Widget _bottomNav() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
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
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
    );
  }
}