import 'package:flutter/material.dart';
import 'order_summary_screen.dart';
import 'shipping_address_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutScreen({
    super.key,
    required this.items,
  });

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {
  String selectedAddressTitle = "Home";
  String selectedAddress =
      "6391 Elgin St. Celina, Delaware 10299, Philippines";
  String selectedPhone =
      "+91587654321";
  String selectedPayment =
      "Cash on Delivery";

  double get orderPrice {
    double total = 0;

    for (var item in widget.items) {
      final price =
          double.tryParse(
                item["price"]
                    .toString(),
              ) ??
              0;

      final qty =
          int.tryParse(
                item["qty"]
                    .toString(),
              ) ??
              1;

      total += price * qty;
    }

    return total;
  }

  double get deliveryPrice =>
      150.00;

  double get summaryPrice =>
      orderPrice +
      deliveryPrice;

  int get itemCount {
    int total = 0;

    for (var item in widget.items) {
      total += int.tryParse(
            item["qty"]
                .toString(),
          ) ??
          1;
    }

    return total;
  }

  String peso(double value) {
    return "₱${value.toStringAsFixed(2)}";
  }

  Future<void> editAddress() async {
    final result =
        await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ShippingAddressScreen(
          currentAddress:
              selectedAddress,
          currentPhone:
              selectedPhone,
        ),
      ),
    );

    if (result != null &&
        result is Map) {
      setState(() {
        selectedAddress =
            result["address"] ??
                selectedAddress;

        selectedPhone =
            result["phone"] ??
                selectedPhone;
      });
    }
  }

  void selectPayment() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(
                "Cash on Delivery"),
            onTap: () {
              setState(() {
                selectedPayment =
                    "Cash on Delivery";
              });

              Navigator.pop(
                  context);
            },
          ),
          ListTile(
            title:
                const Text("GCash"),
            onTap: () {
              setState(() {
                selectedPayment =
                    "GCash";
              });

              Navigator.pop(
                  context);
            },
          ),
          ListTile(
            title: const Text(
                "Mastercard"),
            onTap: () {
              setState(() {
                selectedPayment =
                    "Mastercard";
              });

              Navigator.pop(
                  context);
            },
          ),
        ],
      ),
    );
  }

  Widget itemImage(
      String image) {
    if (image.startsWith(
        "http")) {
      return Image.network(
        image,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      image,
      width: 70,
      height: 70,
      fit: BoxFit.cover,
      errorBuilder:
          (_, __, ___) {
        return const Icon(
          Icons
              .image_not_supported,
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(
              0xFFD2AC67),

      appBar: AppBar(
        backgroundColor:
            const Color(
                0xFFD2AC67),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color:
                Colors.black,
            fontWeight:
                FontWeight
                    .bold,
          ),
        ),
        iconTheme:
            const IconThemeData(
          color:
              Colors.black,
        ),
      ),

      body: widget.items.isEmpty
          ? const Center(
              child: Text(
                "No items to checkout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight
                          .bold,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child:
                      ListView(
                    padding:
                        const EdgeInsets
                            .all(
                            16),
                    children: [
                      _title(
                          "Shipping Address"),

                      _card(
                        child:
                            ListTile(
                          onTap:
                              editAddress,
                          leading:
                              const Icon(
                            Icons
                                .location_on_outlined,
                          ),
                          title:
                              Text(
                            selectedAddressTitle,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle:
                              Text(
                            "$selectedAddress\n$selectedPhone",
                          ),
                          trailing:
                              const Icon(
                            Icons
                                .edit,
                            color:
                                Colors.red,
                          ),
                        ),
                      ),

                      const SizedBox(
                          height:
                              20),

                      _title(
                          "Payment Method"),

                      _card(
                        child:
                            ListTile(
                          onTap:
                              selectPayment,
                          leading:
                              const Icon(
                            Icons
                                .payment,
                          ),
                          title:
                              Text(
                            selectedPayment,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          trailing:
                              const Icon(
                            Icons
                                .arrow_forward_ios,
                          ),
                        ),
                      ),

                      const SizedBox(
                          height:
                              20),

                      _title(
                          "Items"),

                      ...widget
                          .items
                          .map(
                            (
                              item,
                            ) {
                              final name =
                                  item["title"] ??
                                      item["name"];

                              return Padding(
                                padding:
                                    const EdgeInsets.only(
                                  bottom:
                                      10,
                                ),
                                child:
                                    _card(
                                  child:
                                      Row(
                                    children: [
                                      itemImage(
                                        item["image"]
                                            .toString(),
                                      ),

                                      const SizedBox(
                                          width:
                                              12),

                                      Expanded(
                                        child:
                                            Text(
                                          name.toString(),
                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "₱${item["price"]}",
                                          ),
                                          Text(
                                            "Qty: ${item["qty"]}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                      const SizedBox(
                          height:
                              20),

                      _title(
                          "Summary"),

                      _card(
                        child:
                            Column(
                          children: [
                            _row(
                              "Items ($itemCount)",
                              peso(
                                  orderPrice),
                            ),
                            _row(
                              "Delivery",
                              peso(
                                  deliveryPrice),
                            ),
                            const Divider(),
                            _row(
                              "Total",
                              peso(
                                  summaryPrice),
                              bold:
                                  true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  color:
                      Colors.white,
                  padding:
                      const EdgeInsets
                          .all(
                          16),
                  child:
                      SizedBox(
                    width: double
                        .infinity,
                    height:
                        55,
                    child:
                        ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.black,
                      ),
                      onPressed:
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    OrderSummaryScreen(
                              addressTitle:
                                  selectedAddressTitle,
                              address:
                                  "$selectedAddress | $selectedPhone",
                              paymentMethod:
                                  selectedPayment,
                              deliveryMethod:
                                  "FedEx",
                              itemCount:
                                  itemCount,
                              orderPrice:
                                  peso(orderPrice),
                              deliveryPrice:
                                  peso(deliveryPrice),
                              summaryPrice:
                                  peso(summaryPrice),
                              items:
                                  widget.items,
                            ),
                          ),
                        );
                      },
                      child:
                          const Text(
                        "Submit Order",
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _title(
      String text) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Text(
        text,
        style:
            const TextStyle(
          fontSize: 18,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  Widget _card({
    required Widget child,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(
              14),
      decoration:
          BoxDecoration(
        color:
            Colors.white,
        borderRadius:
            BorderRadius.circular(
                16),
      ),
      child: child,
    );
  }

  Widget _row(
    String title,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,
        children: [
          Text(
            title,
            style:
                TextStyle(
              fontWeight: bold
                  ? FontWeight
                      .bold
                  : null,
            ),
          ),
          Text(
            value,
            style:
                TextStyle(
              fontWeight: bold
                  ? FontWeight
                      .bold
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}