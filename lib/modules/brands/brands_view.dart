import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandsView extends StatelessWidget {
  final List<Map<String, String>> brands = [
    {"name": "BMW", "label": "BMW Parts Price", "image": "assets/images/bnw.png"},
    {"name": "Mercedes-Benz", "label": "Mercedes-Benz Parts Price", "image": "assets/images/mercedes.png"},
    {"name": "Audi", "label": "Audi Parts Price", "image": "assets/images/audi.png"},
    {"name": "Volkswagen", "label": "Volkswagen Parts Price", "image": "assets/images/volk.png"},
    {"name": "Toyota", "label": "Toyota Parts Price", "image": "assets/images/toyota.png"},
    {"name": "Honda", "label": "Honda Parts Price", "image": "assets/images/honda.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Automotive Brands",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                itemCount: brands.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 0.65, // reduced to fit height
                ),
                itemBuilder: (context, index) {
                  final brand = brands[index];
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            brand['image']!,
                            height: 140.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "${brand['name']} Parts",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          brand['label']!,
                          style: TextStyle(fontSize: 12.sp, color: Colors.brown.shade400),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
