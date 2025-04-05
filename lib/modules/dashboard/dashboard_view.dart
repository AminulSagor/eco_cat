import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.menu, size: 24.sp),
                    SizedBox(width: 8.w),
                    Text(
                      "Eco Trade",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Icon(Icons.search, size: 24.sp),
              ],
            ),

            SizedBox(height: 24.h),

            Center(
              child: Text(
                "Maximize Scrap Catalyst \nValue",
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                    child: Text("Search a Reference"),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade100,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                    child: Text("Search by Vehicle Model"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 28.h),
            Text(
              "Market Trends",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            Text(
              "PT: +0.3%, PD: +0.4%",
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              "10 days +0.3%",
              style: TextStyle(fontSize: 14.sp, color: Colors.green),
            ),

            SizedBox(height: 20.h),
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.brown.shade100.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text(
                "📈 Chart Placeholder",
                style: TextStyle(color: Colors.brown.shade400, fontSize: 14.sp),
              ),
            ),

            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Platinum", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.brown)),
                Text("Palladium", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.brown)),
                Text("Rhodium", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.brown)),
              ],
            ),
            SizedBox(height: 12.h),

            // Price summary
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Text("3 months +0.4%", style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                  SizedBox(height: 16.h,),
                  Text("1 year +0.5%", style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                  SizedBox(height: 16.h,),
                  Text("5 years", style: TextStyle(fontSize: 14.sp,color: Colors.green)),
                  SizedBox(height: 16.h,),
                  Text("All", style: TextStyle(fontSize: 14.sp,color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
