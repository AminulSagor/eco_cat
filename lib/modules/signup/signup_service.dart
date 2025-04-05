import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../routes/app_pages.dart';

class SignupService {
  final String _baseUrl = "https://nlrcatalysts.com/api";

  Future<void> registerUser(String name, String email, String password) async {
    try {
      final url = Uri.parse("$_baseUrl/signup.php");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        Get.snackbar(
          "Success",
          data['message'] ?? "Registration successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade900,
        );

        // Then navigate
        Get.offNamed(AppPages.INITIAL); // 🔄 replaces current route

      } else {
        Get.snackbar(
          "Failed",
          data['message'] ?? "Something went wrong",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
    }
  }
}
