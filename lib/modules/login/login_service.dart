import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../storage/token_storage.dart';

class LoginService {
  final String _baseUrl = "https://nlrcatalysts.com/api";

  Future<void> loginUser(String email, String password) async {
    try {
      final url = Uri.parse("$_baseUrl/login.php");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        final user = data['user'];
        final token = user['token'];

        await TokenStorage.saveToken(token);

        Get.snackbar(
          "Success",
          "Welcome ${user['name']}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );

        // ✅ Optional: Navigate to home screen
        Get.offAllNamed('/home');

      } else {
        Get.snackbar(
          "Please sign up first",
          data['message'] ?? "Unknown error",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
