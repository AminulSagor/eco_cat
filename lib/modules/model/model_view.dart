// lib/modules/model/model_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'model_controller.dart';
import '../product/product_view.dart'; // 👈 Import the product screen

class ModelView extends StatelessWidget {
  final String subBrandId;
  const ModelView({super.key, required this.subBrandId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModelController());
    controller.loadModels(subBrandId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Models"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.models.isEmpty) {
            return const Center(child: Text("No models found"));
          }

          return GridView.builder(
            itemCount: controller.models.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final model = controller.models[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductView(modelId: model.id)); // 👈 Navigate to product view
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    model.name,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
