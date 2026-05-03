import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedTab = 0;

  String get currentStatus {
    if (selectedTab == 0) return "Pending";
    if (selectedTab == 1) return "Shipped";
    return "Delivered";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),

            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  "My Orders",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  _tab("To Ship", 0),
                  const SizedBox(width: 8),
                  _tab("To Received", 1),
                  const SizedBox(width: 8),
                  _tab("Completed", 2),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('status', isEqualTo: currentStatus)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No orders yet",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data =
                          doc.data() as Map<String, dynamic>;

                      return Container(
                        margin:
                            const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order #${doc.id.substring(0, 6)}",
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  data['status'],
                                  style: TextStyle(
                                    color: data['status'] ==
                                            "Delivered"
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Align(
                              alignment:
                                  Alignment.centerLeft,
                              child: Text(
                                "Total: ${data['summaryPrice']}",
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, int index) {
    final active = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            color:
                active ? Colors.black : Colors.white,
            borderRadius:
                BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: active
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}