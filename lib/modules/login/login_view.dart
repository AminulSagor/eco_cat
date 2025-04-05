import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routes/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh, // Full screen height
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back to the app",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40.h),
              TextField(
                controller: controller.emailController,
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: controller.passwordController,
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
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
                  onPressed: controller.login,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppPages.signUp); // 👈 Navigate using GetX route name
                  },
                  child: Text(
                    "Sign up for an account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
