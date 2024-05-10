class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String img_name;
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
    required this.img_name,
    this.quantity = 1, 
    this.totalOrders = 0.0
    // this.totalPrice = 0.0,
    // required this.ratingRate,
    // required this.ratingCount,
  }): totalPrice = double.parse(price);

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final title = json['title'];
    final price = json['price'].toString();
    final description = json['description'];
    final img_name = json['img_name'];
    final quantity = json['quantity'] ?? 1; 
    // final totalPrice = json['totalPrice'] ?? 0.0;
    // final ratingRate = json['rating']['rate'];
    // final ratingCount = json['rating']['count'];
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      img_name: img_name,
      quantity: quantity,
      // totalPrice: totalPrice,
      // ratingRate: ratingRate,
      // ratingCount: ratingCount,
    );
  }
}