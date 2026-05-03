import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC59D62),
      body: const Center(
        child: Text("Search Page", style: TextStyle(fontSize: 24)),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
