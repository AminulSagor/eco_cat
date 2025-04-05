import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../storage/token_storage.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 60.r,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
              ),
              SizedBox(height: 16.h),
              Text(
                "Sophie Miller",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Text(
                "nobojit@gmail.com",
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 55
                    .h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () async {
                    await TokenStorage.clearToken();
                    Get.offAllNamed(AppPages.INITIAL);
                  },
                  child: Text("Log Out", style: TextStyle(fontSize: 14.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
