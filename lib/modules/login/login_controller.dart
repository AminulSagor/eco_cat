import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_service.dart';
import '../../utils/validation_utils.dart'; // adjust path if needed

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = ValidationUtil.validateEmail(email);
    final passError = ValidationUtil.validatePassword(password);

    if (emailError != null || passError != null) {
      Get.snackbar(
        "Validation Error",
        emailError ?? passError!,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100, // 👈 background
        colorText: Colors.red.shade900,       // 👈 text color
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      return;
    }


    LoginService().loginUser(email, password);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
