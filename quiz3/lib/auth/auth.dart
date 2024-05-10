import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:quiz3/home.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/model/user.dart';
import 'package:quiz3/provider/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://146.190.109.66:8000';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> register(BuildContext context, User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // login(context, user);
      return login(context, user); // registration successful
    } else {
      return false; // registration failed
    }
  }

  Future<bool> login(BuildContext context, User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      var token = json['access_token'];
      var id = json['id'];
      var username = json['username'];
      setToken(token);
      setId(id);
      setUsername(username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoutePage()),
      );
      return true; // login successful
    } else {
      return false; // login failed
    }
  }

  Future<void> setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<void> setId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', value);
  }

  Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') ?? "";
  }

  Future<void> setUsername(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', value);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? "";
  }
}
