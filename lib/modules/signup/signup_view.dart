import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // 👈 navigate back
        ),

      ),
      body: Center( // 👈 Center everything vertically and horizontally
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 👈 so it wraps content tightly
            crossAxisAlignment: CrossAxisAlignment.center, // 👈 center horizontally
            children: [
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: controller.signUp,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "Already have an account? Log in.",
                  style: TextStyle(color: Colors.green, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
