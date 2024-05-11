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

  List<Cart> _cart = [];
  List<Cart> get cart => _cart;

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
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> cartList = jsonDecode(response.body);
        _cart = cartList.map((json) => Cart.fromJson(json)).toList();


        for(Cart item in _cart){
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

  void add(BuildContext context, Cart item) async {
    final value = Provider.of<ProductProvider>(context, listen: false);
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "carts/"),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(item.toJson()),
      );

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _cart.add(Cart.fromJson(json));

        Product product = value.products.firstWhere(
          (product) => product.id == item.item_id,
          orElse: () => Product(id: "", title: "", price: "", description: "", img_name: ""),
        );

        // If a corresponding product is found, add it to the items list
        if (product.id != "" && product.title != "") {
          _items.add(product);
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void remove(BuildContext context, String cartId) async {
    // notifyListeners();
    final value = Provider.of<ProductProvider>(context, listen: false);
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();

      Cart cartDel = _cart.firstWhere(
        (item) => item.id == cartId,
        orElse: () => Cart(item_id: '', user_id: '', quantity: '', id: ''),
      );

      final response = await http.delete(
        Uri.parse(url + "carts/" + cartId),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Product product = value.products.firstWhere(
        (product) => product.id == cartDel.item_id,
        orElse: () => Product(id: "", title: "", price: "", description: "", img_name: ""),
      );

      // If a corresponding product is found, add it to the items list
      if (product.id != "") {
        _items.remove(product);
      }

      _cart.remove(cartDel);

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete data');
    }
  }

  void removeAll() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();

      final response = await http.delete(
        Uri.parse(url + "clear_whole_carts_by_userid/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      _items = [];
      _cart = [];

      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete data');
    }
  }

  bool isProductExists(String productId) {
    return _cart.any((product) => product.item_id == productId);
  }
}
