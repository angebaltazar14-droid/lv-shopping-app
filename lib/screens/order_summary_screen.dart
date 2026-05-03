import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderSummaryScreen extends StatefulWidget {
  final String addressTitle;
  final String address;
  final String paymentMethod;
  final String deliveryMethod;
  final int itemCount;
  final String orderPrice;
  final String deliveryPrice;
  final String summaryPrice;
  final List<Map<String, dynamic>> items;

  const OrderSummaryScreen({
    super.key,
    required this.addressTitle,
    required this.address,
    required this.paymentMethod,
    required this.deliveryMethod,
    required this.itemCount,
    required this.orderPrice,
    required this.deliveryPrice,
    required this.summaryPrice,
    required this.items,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool isLoading = false;

  String formatPeso(dynamic value) {
    if (value is String) return value;
    if (value is int) return "₱${value.toStringAsFixed(2)}";
    if (value is double) return "₱${value.toStringAsFixed(2)}";
    return "₱0.00";
  }

  Future<void> confirmOrder() async {
    setState(() => isLoading = true);

    try {
      for (var item in widget.items) {
        final query = await FirebaseFirestore.instance
            .collection('products')
            .where('name', isEqualTo: item['title'])
            .limit(1)
            .get();

        if (query.docs.isNotEmpty) {
          final doc = query.docs.first;
          final currentStock = int.tryParse(doc['stock'].toString()) ?? 0;
          final qty = int.tryParse(item['qty'].toString()) ?? 1;
          final newStock = currentStock - qty;

          await FirebaseFirestore.instance
              .collection('products')
              .doc(doc.id)
              .update({
            'stock': newStock < 0 ? 0 : newStock,
          });
        }
      }

      await FirebaseFirestore.instance.collection('orders').add({
        'addressTitle': widget.addressTitle,
        'address': widget.address,
        'paymentMethod': widget.paymentMethod,
        'deliveryMethod': widget.deliveryMethod,
        'itemCount': widget.itemCount,
        'orderPrice': widget.orderPrice,
        'deliveryPrice': widget.deliveryPrice,
        'summaryPrice': widget.summaryPrice,
        'items': widget.items,
        'status': 'Pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Order Placed"),
          content: const Text(
            "Your order has been submitted successfully.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order failed: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2B074),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2B074),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Order Summary",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle("Delivery Address"),
            const SizedBox(height: 10),
            _buildCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.location_on_outlined),
                title: Text(
                  widget.addressTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.address),
              ),
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("Payment Method"),
            const SizedBox(height: 10),
            _buildCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.payment),
                title: Text(
                  widget.paymentMethod,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Delivery: ${widget.deliveryMethod}"),
              ),
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("Ordered Items"),
            const SizedBox(height: 10),
            ...widget.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildItemRow(item),
              ),
            ),

            const SizedBox(height: 20),

            _buildSectionTitle("Payment Summary"),
            const SizedBox(height: 10),
            _buildCard(
              child: Column(
                children: [
                  _buildSummaryRow(
                    "Items (${widget.itemCount})",
                    widget.orderPrice,
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    "Delivery Fee",
                    widget.deliveryPrice,
                  ),
                  const Divider(height: 24),
                  _buildSummaryRow(
                    "Total Payment",
                    widget.summaryPrice,
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : confirmOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Confirm Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item["image"],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item["title"] ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatPeso(item["price"]),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text("Qty: ${item["qty"] ?? 1}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}