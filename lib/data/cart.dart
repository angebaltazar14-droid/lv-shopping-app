List<Map<String, dynamic>> cartItems = [];

void addToCart({
  required String name,
  required dynamic price,
  required String image,
}) {
  final existingIndex = cartItems.indexWhere(
    (item) => item['name'] == name && item['image'] == image,
  );

  String cleanPrice = price.toString();
  cleanPrice = cleanPrice.replaceAll('₱', '').replaceAll('\$', '').trim();

  if (existingIndex != -1) {
    cartItems[existingIndex]['qty'] =
        (cartItems[existingIndex]['qty'] as int) + 1;
  } else {
    cartItems.add({
      'name': name,
      'price': cleanPrice,
      'image': image,
      'qty': 1,
    });
  }
}

void updateQty(int index, int change) {
  cartItems[index]['qty'] = (cartItems[index]['qty'] as int) + change;

  if (cartItems[index]['qty'] <= 0) {
    cartItems.removeAt(index);
  }
}

String getTotalAmount() {
  double total = 0;

  for (final item in cartItems) {
    final price = double.tryParse(item['price'].toString()) ?? 0;
    final qty = item['qty'] as int;
    total += price * qty;
  }

  return total.toStringAsFixed(0);
}

void clearCart() {
  cartItems.clear();
}