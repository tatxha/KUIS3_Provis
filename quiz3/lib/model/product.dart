class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String img_name;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.img_name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'].toString();
    final title = json['title'];
    final price = json['price'].toString();
    final description = json['description'];
    final img_name = json['img_name'];
    final quantity = json['quantity'] ?? 1; 
    
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      img_name: img_name,
    );
  }
}