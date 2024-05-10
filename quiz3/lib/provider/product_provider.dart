import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  static String url = "http://146.190.109.66:8000/";

  AuthService auth = AuthService();

  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _chart = [];
  List<Product> get chart => _chart;

  Future<void> fetchData() async {
    try {
      String token = await auth.getToken();
      final response = await http.get(
        Uri.parse(url + "items/"),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> productList = jsonDecode(response.body);
        _products = productList.map((json) => Product.fromJson(json)).toList();

        // for(Product product in _products){
        //   final responseImg = await http.get(
        //     Uri.parse(url + "items_image/"+product.id),
        //     headers: <String, String>{
        //       'accept': 'application/json',
        //       'Authorization': 'Bearer $token',
        //     },
        //   );
        //   if (responseImg.statusCode == 200) {
        //     final dynamic imageData = jsonDecode(responseImg.body);
        //     print(imageData);
        //     String imageUrl = imageData; // Adjust according to your API response structure
        //     _images.add(imageUrl);
        //   } else {
        //     throw Exception('Failed to load image');
        //   }
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
    notifyListeners();
  }

  void remove(Product product) {
    _chart.remove(product);
    notifyListeners();
  }

  bool isProductExists(String productId) {
    return _chart.any((product) => product.id == productId);
  }
}
