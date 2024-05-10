class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  int quantity;
  double totalPrice;
  double totalOrders;
  // final String ratingRate;
  // final String ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.quantity = 1, 
    this.totalOrders = 0.0
    // this.totalPrice = 0.0,
    // required this.ratingRate,
    // required this.ratingCount,
  }): totalPrice = double.parse(price);

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final title = json['title'];
    final price = json['price'].toStringAsFixed(2);
    final description = json['description'];
    final category = json['category'];
    final image = json['image'];
    final quantity = json['quantity'] ?? 1; 
    // final totalPrice = json['totalPrice'] ?? 0.0;
    // final ratingRate = json['rating']['rate'];
    // final ratingCount = json['rating']['count'];
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      quantity: quantity,
      // totalPrice: totalPrice,
      // ratingRate: ratingRate,
      // ratingCount: ratingCount,
    );
  }
}