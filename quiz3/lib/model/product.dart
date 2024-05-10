class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  // final String ratingRate;
  // final String ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    // required this.ratingRate,
    // required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final title = json['title'];
    final price = json['price'].toStringAsFixed(2);
    final description = json['description'];
    final category = json['category'];
    final image = json['image'];
    // final ratingRate = json['rating']['rate'];
    // final ratingCount = json['rating']['count'];
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      // ratingRate: ratingRate,
      // ratingCount: ratingCount,
    );
  }
}