import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/model/cart.dart';
import 'package:quiz3/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:quiz3/provider/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  static String url = "http://146.190.109.66:8000/";

  AuthService auth = AuthService();

  List<Cart> _chart = [];
  List<Cart> get chart => _chart;

  List<Product> _items = [];
  List<Product> get items => _items;

  Future<void> fetchData(BuildContext context) async {
    final value = Provider.of<ProductProvider>(context);
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.get(
        Uri.parse(url + "carts/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> cartList = jsonDecode(response.body);
        _chart = cartList.map((json) => Cart.fromJson(json)).toList();

        for(Cart item in _chart){
          // Find the product with the same item ID
          Product product = value.products.firstWhere(
            (product) => product.id == item.item_id,
            orElse: () => Product(id: "", title: "", price: "", description: "", img_name: ""),
          );

          // If a corresponding product is found, add it to the items list
          if (product.id != "") {
            _items.add(product);
          }
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // void add(Product product) {
  //   _chart.add(product);
  //   notifyListeners();
  // }

  // void remove(Product product) {
  //   _chart.remove(product);
  //   notifyListeners();
  // }

  // bool isProductExists(String productId) {
  //   return _chart.any((product) => product.id == productId);
  // }
}
