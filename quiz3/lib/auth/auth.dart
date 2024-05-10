import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quiz3/home.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/model/user.dart';

class AuthService {
  final String baseUrl = 'http://146.190.109.66:8000';

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
      return login(context, user);; // registration successful
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
      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoutePage()),
      );
      return true; // login successful
    } else {
      return false; // login failed
    }
  }
}
