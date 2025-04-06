import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_service.dart';
import '../../utils/validation_utils.dart';
import '../../storage/token_storage.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final creds = await TokenStorage.getSavedCredentials();
    if (creds != null) {
      emailController.text = creds['email']!;
      passwordController.text = creds['password']!;
      rememberMe.value = true;
    }
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = ValidationUtil.validateEmail(email);
    final passError = ValidationUtil.validatePassword(password);

    if (emailError != null || passError != null) {
      Get.snackbar(
        "Validation Error",
        emailError ?? passError!,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    // Save or clear credentials based on rememberMe
    if (rememberMe.value) {
      await TokenStorage.saveCredentials(email, password);
    } else {
      await TokenStorage.clearCredentials();
    }

    LoginService().loginUser(email, password, rememberMe.value);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
