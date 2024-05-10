class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String img_name;
  // final String ratingRate;
  // final String ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.img_name,
    // required this.ratingRate,
    // required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final title = json['title'];
    final price = json['price'].toString();
    final description = json['description'];
    final img_name = json['img_name'];
    // final ratingRate = json['rating']['rate'];
    // final ratingCount = json['rating']['count'];
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      img_name: img_name,
      // ratingRate: ratingRate,
      // ratingCount: ratingCount,
    );
  }
}