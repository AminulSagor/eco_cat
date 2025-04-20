// lib/modules/product/product_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductView extends StatelessWidget {
  final String modelId;
  const ProductView({super.key, required this.modelId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    controller.loadProducts(modelId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Price: ${product.price}", style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
