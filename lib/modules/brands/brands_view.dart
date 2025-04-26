import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../product/product_view.dart';
import 'brand_controller.dart';

class BrandsView extends StatelessWidget {
  final controller = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(
        appBar: AppBar(title: const Text('Brands')),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: List.generate((controller.brands.length / 2).ceil(), (
                rowIndex,
              ) {
                final firstIndex = rowIndex * 2;
                final secondIndex = firstIndex + 1;

                final List<Widget> rowWidgets = [];
                rowWidgets.add(_buildBrandCard(firstIndex));

                if (secondIndex < controller.brands.length) {
                  rowWidgets.add(_buildBrandCard(secondIndex));
                }

                final isFirstExpanded =
                    controller.expandedIndex.value == firstIndex;
                final isSecondExpanded =
                    controller.expandedIndex.value == secondIndex;

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          rowWidgets[0],
                          if (rowWidgets.length == 2) ...[
                            SizedBox(width: 12.w),
                            rowWidgets[1],
                          ],
                          if (rowWidgets.length == 1)
                            SizedBox(width: (Get.width - 36.w) / 2),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      if (isFirstExpanded)
                        _buildSubBrandsContainer(
                          controller.subBrandsMap[controller
                                  .brands[firstIndex]['id']] ??
                              [],
                        ),
                      if (isSecondExpanded)
                        _buildSubBrandsContainer(
                          controller.subBrandsMap[controller
                                  .brands[secondIndex]['id']] ??
                              [],
                        ),
                    ],
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBrandCard(int index) {
    final brand = controller.brands[index];
    final brandId = brand['id'];
    final isExpanded = controller.expandedIndex.value == index;
    final brandName = brand['brand_name'] ?? '';
    final wordCount = brandName.split(' ').length;

    return Container(
      width: (Get.width - 36.w) / 2,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: GestureDetector(
        onTap: () => controller.toggleSubBrands(brandId, index),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              brand['image_path'] ?? '',
              height: 60,
              width: 60,
              fit: BoxFit.cover,

            ),
            SizedBox(width: 8.w),

            Expanded(  // <-- Add this Expanded
              child: Text(
                brandName,
                style: TextStyle(
                  fontSize: wordCount > 1 ? 12.sp : 14.sp,
                  fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubBrandsContainer(List subBrands) {
    return Container(
      width: Get.width - 24.w,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: subBrands.isEmpty
          ? Center(
              child: Text(
                "No sub-brands found",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            )
          : Column(
              children: List.generate((subBrands.length / 2).ceil(), (
                rowIndex,
              ) {
                final firstIndex = rowIndex * 2;
                final secondIndex = firstIndex + 1;

                final List<Widget> rowWidgets = [];

                rowWidgets.add(_buildSubBrandCard(subBrands[firstIndex]));

                if (secondIndex < subBrands.length) {
                  rowWidgets.add(_buildSubBrandCard(subBrands[secondIndex]));
                }

                final isFirstExpanded =
                    controller.expandedSubBrandId.value ==
                    subBrands[firstIndex]['id'];
                final isSecondExpanded =
                    secondIndex < subBrands.length &&
                    controller.expandedSubBrandId.value ==
                        subBrands[secondIndex]['id'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        rowWidgets[0],
                        if (rowWidgets.length == 2) ...[
                          SizedBox(width: 8.w),
                          rowWidgets[1],
                        ],
                        if (rowWidgets.length == 1)
                          SizedBox(width: (Get.width - 24.w - 8.w) / 2),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    if (isFirstExpanded)
                      _buildModelsGrid(
                        controller.modelsMap[subBrands[firstIndex]['id']] ?? [],
                      ),
                    if (isSecondExpanded)
                      _buildModelsGrid(
                        controller.modelsMap[subBrands[secondIndex]['id']] ??
                            [],
                      ),
                  ],
                );
              }),
            ),
    );
  }

  Widget _buildSubBrandCard(Map subBrand) {
    final subBrandId = subBrand['id'];
    final isSelected = controller.expandedSubBrandId.value == subBrandId;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.toggleModels(subBrandId),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  subBrand['name'],
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModelsGrid(List models) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: models.isEmpty
          ? Center(
              child: Text(
                "No models found",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: models.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 3.5,
              ),
              itemBuilder: (context, index) {
                final model = models[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductView(modelId: model['id']));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        model['name'] ?? 'Unnamed Model',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildModelsContainer(List models) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: models.isEmpty
          ? Center(
              child: Text(
                "No models found",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              // Added to avoid overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: models.map<Widget>((model) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      model['name'] ?? 'Unnamed Model', // Fallback
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
