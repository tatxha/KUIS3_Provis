class Cart {
  final String item_id;
  final String user_id;
  String quantity;
  final String id;

  Cart({
    required this.item_id,
    required this.user_id,
    required this.quantity,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': int.parse(item_id),
      'user_id': int.parse(user_id),
      'quantity': int.parse(quantity),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    final item_id = json['item_id'].toString();
    final user_id = json['user_id'].toString();
    final quantity = json['quantity'].toString();
    final id = json['id'].toString();
    
    return Cart(
      item_id: item_id,
      user_id: user_id,
      quantity: quantity,
      id: id,
    );
  }
}
