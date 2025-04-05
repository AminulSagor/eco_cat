import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_service.dart';
import '../../utils/validation_utils.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailError = ValidationUtil.validateEmail(email);
    final passError = ValidationUtil.validatePassword(password);
    final nameError = ValidationUtil.validateName(name);

    if (nameError != null || emailError != null || passError != null) {
      Get.snackbar("Validation Error", nameError ?? emailError ?? passError!);
      return;
    }


    SignupService().registerUser(name, email, password);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
