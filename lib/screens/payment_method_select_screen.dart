import 'package:flutter/material.dart';

class PaymentMethodSelectScreen extends StatefulWidget {
  final String selected;

  const PaymentMethodSelectScreen({super.key, required this.selected});

  @override
  State<PaymentMethodSelectScreen> createState() =>
      _PaymentMethodSelectScreenState();
}

class _PaymentMethodSelectScreenState
    extends State<PaymentMethodSelectScreen> {
  late String selectedMethod;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2AC67),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "PAYMENT METHOD",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _item("COD"),
              const SizedBox(height: 20),
              _item("GCash"),
              const SizedBox(height: 20),
              _item("BPI"),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, selectedMethod);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("CONFIRM"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 CLICKABLE ITEM
  Widget _item(String name) {
    final bool selected = selectedMethod == name;

    return InkWell(
      onTap: () {
        setState(() {
          selectedMethod = name;
        });
      },
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}