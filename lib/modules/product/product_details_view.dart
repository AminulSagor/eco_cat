import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductDetailsView extends StatefulWidget {
  final String productId;
  const ProductDetailsView({super.key, required this.productId});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.green.shade700,
          elevation: 0,
          leadingWidth: 100, // Adjust width to fit both icons
          leading: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              Icon(Icons.nature, color: Colors.white), // Details icon
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () => controller.loadProductDetails(widget.productId),
            ),
          ],
        ),

        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          final product = controller.productDetails;
          if (product.isEmpty) {
            return const Center(child: Text("Product details not found", style: TextStyle(color: Colors.white)));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Full-width image
                Image.network(
                  product['img_path'] ?? '',
                  height: 200.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, color: Colors.white, size: 80),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        "CODE",
                        product['code'] ?? '',
                        icon: Icons.mark_chat_unread,
                        iconColor: Colors.red,
                        valueColor: Colors.tealAccent,
                      ),
                      SizedBox(height: 30.h),
                      _buildInfoRow(
                        "Quantity",
                        "1",
                        icon: Icons.expand_less,
                        iconColor: Colors.orange,
                      ),
                      SizedBox(height: 30.h),
                      _buildInfoRow(
                        "PRICE",
                        "AED ${product['price'] ?? '0'}",
                        icon: Icons.price_change,
                        iconColor: Colors.red,
                        valueColor: Colors.green,
                      ),
                      SizedBox(height: 30.h),
                      _buildInfoRow("Weight/KG", product['weight'] ?? '0'),
                      SizedBox(height: 30.h),
                      _buildInfoRow("RH", product['rhodium_weight'] ?? '0'),
                      SizedBox(height: 30.h),
                      _buildInfoRow("PD", product['palladium_weight'] ?? '0'),
                      SizedBox(height: 30.h),
                      _buildInfoRow("PT", product['platinum_weight'] ?? '0'),

                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {IconData? icon, Color? iconColor, Color? valueColor}) {
    final isPrice = label.toUpperCase() == "PRICE"; // Check if label is PRICE
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
          ),
        ),
        if (icon != null)
          Icon(icon, color: iconColor, size: 18.sp),
        SizedBox(width: 8.w),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 18.sp,
              fontWeight: isPrice ? FontWeight.bold : FontWeight.normal, // Bold only for PRICE
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildSimpleRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 16.sp)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
      ],
    );
  }
}
