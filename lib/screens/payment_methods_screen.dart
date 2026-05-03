import 'package:flutter/material.dart';
import '../data/cart.dart';
import 'order_summary_screen.dart';
import 'shipping_address_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool isStandard = true;

  String selectedAddress = "URDANETA CITY PANGASINAN KM WEST ZONE 2";
  String selectedPhone = "+91587654321";
  String paymentMethod = "Card";

  double get orderPrice {
    double total = 0;
    for (var item in cartItems) {
      final price = double.tryParse(item["price"].toString()) ?? 0;
      final qty = int.tryParse(item["qty"].toString()) ?? 1;
      total += price * qty;
    }
    return total;
  }

  double get deliveryPrice => isStandard ? 0 : 12;

  double get summaryPrice => orderPrice + deliveryPrice;

  int get itemCount {
    int total = 0;
    for (var item in cartItems) {
      total += int.tryParse(item["qty"].toString()) ?? 1;
    }
    return total;
  }

  String peso(double value) {
    return "₱${value.toStringAsFixed(2)}";
  }

  Future<void> editAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ShippingAddressScreen(
          currentAddress: selectedAddress,
          currentPhone: selectedPhone,
        ),
      ),
    );

    if (result != null && result is Map) {
      setState(() {
        selectedAddress = result["address"] ?? selectedAddress;
        selectedPhone = result["phone"] ?? selectedPhone;
      });
    }
  }

  void selectPayment() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text("Cash on Delivery"),
            onTap: () {
              setState(() => paymentMethod = "Cash on Delivery");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: const Text("GCash"),
            onTap: () {
              setState(() => paymentMethod = "GCash");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text("Card"),
            onTap: () {
              setState(() => paymentMethod = "Card");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget itemImage(String image) {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        width: 55,
        height: 55,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      image,
      width: 55,
      height: 55,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.image_not_supported);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2AC67),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "No items yet",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("Shipping Address"),
                  infoBox(
                    title: selectedAddress,
                    icon: Icons.edit,
                    onTap: editAddress,
                  ),

                  const SizedBox(height: 20),

                  sectionTitle("Contact Information"),
                  infoBox(
                    title: selectedPhone,
                    icon: Icons.edit,
                    onTap: editAddress,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Text(
                        "Items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black,
                        child: Text(
                          "$itemCount",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  ...cartItems.map((item) {
                    final name =
                        item["title"]?.toString() ?? item["name"].toString();

                    return itemTile(
                      item["image"].toString(),
                      name,
                      "₱${item["price"]}",
                      item["qty"] ?? 1,
                    );
                  }),

                  const SizedBox(height: 20),

                  sectionTitle("Shipping Options"),
                  shippingOption(
                    title: "Standard",
                    time: "5–7 days",
                    price: "FREE",
                    selected: isStandard,
                    onTap: () {
                      setState(() => isStandard = true);
                    },
                  ),
                  shippingOption(
                    title: "Express",
                    time: "1–2 days",
                    price: "₱12.00",
                    selected: !isStandard,
                    onTap: () {
                      setState(() => isStandard = false);
                    },
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isStandard
                        ? "Delivered within 5–7 days"
                        : "Delivered within 1–2 days",
                    style: const TextStyle(fontSize: 12),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sectionTitle("Payment Method"),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: selectPayment,
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: selectPayment,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5E3C3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card, color: Colors.black),
                          const SizedBox(width: 10),
                          Text(
                            paymentMethod,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  sectionTitle("Summary"),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5E3C3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        summaryRow("Items", peso(orderPrice)),
                        summaryRow("Delivery", peso(deliveryPrice)),
                        const Divider(),
                        summaryRow("Total", peso(summaryPrice), bold: true),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderSummaryScreen(
                              addressTitle: "Home",
                              address: "$selectedAddress | Phone: $selectedPhone",
                              paymentMethod: paymentMethod,
                              deliveryMethod: isStandard ? "Standard" : "Express",
                              itemCount: itemCount,
                              orderPrice: peso(orderPrice),
                              deliveryPrice: peso(deliveryPrice),
                              summaryPrice: peso(summaryPrice),
                              items: cartItems,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Submit Order",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
    );
  }

  Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget infoBox({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5E3C3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 14)),
            ),
            Icon(icon, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget itemTile(String img, String text, String price, dynamic qty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          itemImage(img),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text("Qty: $qty"),
            ],
          ),
        ],
      ),
    );
  }

  Widget shippingOption({
    required String title,
    required String time,
    required String price,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5E3C3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16)),
                  Text(time, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
        ],
      ),
    );
  }
}