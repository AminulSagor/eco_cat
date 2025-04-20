// lib/modules/sub_brand/sub_brand_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'sub_brand_controller.dart';
import '../model/model_view.dart'; // 👈 Import the ModelView screen

class SubBrandView extends StatelessWidget {
  final String brandId;
  const SubBrandView({super.key, required this.brandId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubBrandController());
    controller.loadSubBrands(brandId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sub Brands", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.subBrands.isEmpty) {
            return const Center(child: Text("No sub-brands found"));
          }
          return GridView.builder(
            itemCount: controller.subBrands.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final brand = controller.subBrands[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ModelView(subBrandId: brand['id']));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    brand['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
