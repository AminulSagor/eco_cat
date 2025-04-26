import 'package:eco_cat/modules/product/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../storage/token_storage.dart';
import 'product_controller.dart';

class ProductView extends StatelessWidget {
  final String modelId;
  final controller = Get.put(ProductController());

  ProductView({required this.modelId});

  @override
  Widget build(BuildContext context) {
    controller.loadProducts(modelId);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return GestureDetector(
                onTap: () async {
                  final token = await TokenStorage.getToken();
                  if (token != null) {
                    Get.to(() => ProductDetailsView(productId: product['id']));
                  } else {
                    Get.defaultDialog(
                      title: "Login Required",
                      middleText: "Please log in to view product details.",
                      textCancel: "Cancel",
                      textConfirm: "Login",
                      onConfirm: () {
                        Get.back();
                        Get.offAllNamed('/login');
                      },
                    );
                  }
                },

                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Code on top right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(), // Empty space to push code to right
                            Text(
                              "Code: ${product['code'] ?? 'N/A'}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                
                        // Product Image Centered
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              product['img_path'] ?? '',
                              height: 140.h,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                
                        // Product Name & Weight
                        Text(
                          product['product_name'] ?? 'Unnamed Product',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Weight: ${product['weight'] ?? 'N/A'}",
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                        ),
                      ],
                    ),
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
