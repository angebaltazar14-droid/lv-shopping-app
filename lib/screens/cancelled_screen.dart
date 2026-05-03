import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD2AC67),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Cancelled",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'Cancelled')
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
                "No cancelled orders yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
            ),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data =
                  doc.data() as Map<String, dynamic>;

              return buildCancelledItem(
                orderId:
                    "#${doc.id.substring(0, 6)}",
                total:
                    data["summaryPrice"] ??
                        "₱0.00",
              );
            },
          );
        },
      ),
    );
  }

  Widget buildCancelledItem({
    required String orderId,
    required String total,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cancel,
            size: 45,
            color: Colors.red,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  "Order $orderId",
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text("Total: $total"),
              ],
            ),
          ),

          const Text(
            "Cancelled",
            style: TextStyle(
              color: Colors.red,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}