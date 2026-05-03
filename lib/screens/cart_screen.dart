import 'package:flutter/material.dart';
import '../data/cart.dart';
import 'checkout_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "My Cart",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        "No items in cart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      padding: const EdgeInsets.all(14),
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final image =
                            item['image'].toString();

                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFF5E3C3),
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(
                                    8,
                                  ),
                                  child:
                                      image.startsWith(
                                    "http",
                                  )
                                          ? Image.network(
                                              image,
                                              fit: BoxFit
                                                  .cover,
                                            )
                                          : Image.asset(
                                              image,
                                              fit: BoxFit
                                                  .cover,
                                              errorBuilder:
                                                  (_,
                                                      __,
                                                      ___) {
                                                return Container(
                                                  color: Colors
                                                      .white,
                                                  alignment:
                                                      Alignment
                                                          .center,
                                                  child: const Icon(
                                                    Icons
                                                        .image_not_supported,
                                                  ),
                                                );
                                              },
                                            ),
                                ),
                              ),

                              const SizedBox(
                                width: 15,
                              ),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      item['name']
                                          .toString(),
                                      style:
                                          const TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                updateQty(
                                                  index,
                                                  -1,
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              const CircleAvatar(
                                            radius:
                                                14,
                                            backgroundColor:
                                                Colors
                                                    .white,
                                            child:
                                                Icon(
                                              Icons
                                                  .remove,
                                              size:
                                                  18,
                                              color:
                                                  Colors
                                                      .black,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          width:
                                              10,
                                        ),

                                        Text(
                                          "${item['qty']}",
                                          style:
                                              const TextStyle(
                                            fontSize:
                                                16,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                          width:
                                              10,
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                updateQty(
                                                  index,
                                                  1,
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              const CircleAvatar(
                                            radius:
                                                14,
                                            backgroundColor:
                                                Colors
                                                    .white,
                                            child:
                                                Icon(
                                              Icons
                                                  .add,
                                              size:
                                                  18,
                                              color:
                                                  Colors
                                                      .black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                "₱${item['price']}",
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  const Text(
                    "Total Amount:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "₱${getTotalAmount()}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding:
                  const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red.shade600,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CheckoutScreen(
                                items:
                                    cartItems,
                              ),
                            ),
                          );
                        },
                  child: const Text(
                    "CHECK OUT",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return ClipRRect(
      borderRadius:
          const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        currentIndex:
            _currentIndex,
        onTap: (index) {
          setState(() =>
              _currentIndex = index);

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const HomeScreen(),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const SearchScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const ProfileScreen(),
              ),
            );
          }
        },
        type:
            BottomNavigationBarType.fixed,
        selectedItemColor:
            Colors.brown,
        unselectedItemColor:
            Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon:
                Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .shopping_cart_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}