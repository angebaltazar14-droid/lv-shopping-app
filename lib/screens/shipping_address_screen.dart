import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  final String currentAddress;
  final String currentPhone;

  const ShippingAddressScreen({
    super.key,
    required this.currentAddress,
    required this.currentPhone,
  });

  @override
  State<ShippingAddressScreen> createState() =>
      _ShippingAddressScreenState();
}

class _ShippingAddressScreenState
    extends State<ShippingAddressScreen> {
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    addressController =
        TextEditingController(
      text: widget.currentAddress,
    );

    phoneController =
        TextEditingController(
      text: widget.currentPhone,
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFD2AC67),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFD2AC67),
        elevation: 0,
        iconTheme:
            const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Shipping Address",
          style: TextStyle(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Address",
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _field(
              controller:
                  addressController,
              maxLines: 3,
            ),

            const SizedBox(
              height: 25,
            ),

            const Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _field(
              controller:
                  phoneController,
              keyboard:
                  TextInputType.phone,
            ),

            const SizedBox(
              height: 35,
            ),

            SizedBox(
              width:
                  double.infinity,
              height: 52,
              child:
                  ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.black,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                    context,
                    {
                      "address":
                          addressController
                              .text
                              .trim(),
                      "phone":
                          phoneController
                              .text
                              .trim(),
                    },
                  );
                },
                child:
                    const Text(
                  "Save Changes",
                  style:
                      TextStyle(
                    color:
                        Colors.white,
                    fontSize:
                        16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboard =
        TextInputType.text,
  }) {
    return Container(
      decoration:
          BoxDecoration(
        color:
            const Color(
                0xFFF5E3C3),
        borderRadius:
            BorderRadius.circular(
                12),
      ),
      child: TextField(
        controller:
            controller,
        maxLines:
            maxLines,
        keyboardType:
            keyboard,
        decoration:
            const InputDecoration(
          border:
              InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(
            horizontal:
                14,
            vertical:
                14,
          ),
        ),
      ),
    );
  }
}