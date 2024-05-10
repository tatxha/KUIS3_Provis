import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz3/model/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  String url = "https://fakestoreapi.com/products";
  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _chart = [];
  List<Product> get chart => _chart;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        final List<dynamic> productList = jsonDecode(response.body);
        // print(productList);
        _products = productList.map((json) => Product.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void add(Product product) {
    _chart.add(product);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Product product) {
    _chart.remove(product);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  bool isProductExists(String productId) {
    return _chart.any((product) => product.id == productId);
  }
}