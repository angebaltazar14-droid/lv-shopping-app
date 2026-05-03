class Product {
  final String name;
  final String price;
  final String image;    // image path (assets/..)
  final String category; // sling, backpack, all

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

List<Product> demoProducts = [
  Product(
    name: "LOUIS VUITTON SLING",
    price: "₱11,000",
    image: "assets/sling_bag.png",
    category: "sling",
  ),
  Product(
    name: "LV DENIM SAC",
    price: "₱8,000",
    image: "assets/backpack.png",
    category: "backpack",
  ),
  Product(
    name: "BLACK LV SLING",
    price: "₱9,000",
    image: "assets/bag1.png",
    category: "sling",
  ),
  Product(
    name: "LV BACKPACK BROWN",
    price: "₱12,000",
    image: "assets/bag2.png",
    category: "backpack",
  ),
];
