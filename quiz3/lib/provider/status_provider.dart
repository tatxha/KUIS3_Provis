import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/model/cart.dart';
import 'package:quiz3/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:quiz3/model/status.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusProvider extends ChangeNotifier {
  static String url = "http://146.190.109.66:8000/";

  AuthService auth = AuthService();

  List<Status> _chart = [];
  List<Status> get chart => _chart;

  List<Product> _items = [];
  List<Product> get items => _items;

  Status _current = Status(user_id: '', status: '', timestamp: '', id: '');
  Status get current => _current;

  Future<void> fetchData() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.get(
        Uri.parse(url + "get_status/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJsonFetch(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> unpaid() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "set_status_harap_bayar/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJson(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pay() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "pembayaran/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJsonPembayaran(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> accept() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "set_status_penjual_terima/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJson(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> reject() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "set_status_penjual_tolak/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJson(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> onTheWay() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "set_status_diantar/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJson(json);
        print(_current.status);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> delivered() async {
    try {
      String token = await auth.getToken();
      String user_id = await auth.getId();
      final response = await http.post(
        Uri.parse(url + "set_status_diterima/" + user_id),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '',
      );
      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        _current = Status.fromJson(json);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
