import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../search/search_by_reference_view.dart';
import 'dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final controller = Get.put(DashboardController());

  String _getMonthShortName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.menu, size: 24.sp),
                      SizedBox(width: 8.w),
                      Text(
                        "Eco Trade",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.search, size: 24.sp),
                ],
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  "Maximize Scrap Catalyst \nValue",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => SearchByReferenceView()); // 👈 Navigate to Search Page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text("Search a Reference"),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/brands');  // 👈 Navigate to the brands page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade100,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text("Search by Vehicle Model"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: ["5 days", "3 months", "1 year", "5 years", "All"]
                        .map((label) {
                          final isSelected =
                              label == controller.selectedFilter.value;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => controller.onFilterSelected(label),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green
                                      : Colors.transparent,
                                  borderRadius: label == "5 days"
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(12.r),
                                          bottomLeft: Radius.circular(12.r),
                                        )
                                      : label == "All"
                                      ? BorderRadius.only(
                                          topRight: Radius.circular(12.r),
                                          bottomRight: Radius.circular(12.r),
                                        )
                                      : BorderRadius.zero,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Market Trends",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: "PT: ", style: TextStyle(color: Colors.amber.shade700)),
                      TextSpan(text: "${controller.platinumIncrease.value}", style: TextStyle(color: Colors.amber.shade700)),
                      WidgetSpan(child: SizedBox(width: 16.w)), // Add space here

                      TextSpan(text: "PD: ", style: TextStyle(color: Colors.blue)),
                      TextSpan(text: "${controller.palladiumIncrease.value}", style: TextStyle(color: Colors.blue)),
                      WidgetSpan(child: SizedBox(width: 16.w)), // Add space here

                      TextSpan(text: "RH: ", style: TextStyle(color: Colors.green)),
                      TextSpan(text: controller.rhodiumIncrease.value, style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),



              SizedBox(height: 4.h),
              Obx(
                () => Text(
                  "${controller.selectedFilter.value} +0.3%",
                  style: TextStyle(fontSize: 14.sp, color: Colors.green),
                ),
              ),
              SizedBox(height: 24.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.graphData.isEmpty) {
                  return Text(
                    "No data available",
                    style: TextStyle(color: Colors.brown.shade400),
                  );
                }
                return Container(
                  height: 250.h,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (controller.graphData.length - 1).toDouble(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                              getTitlesWidget: (value, meta) {
                                int reversedIndex = (controller.graphData.length - 1 - value.toInt());
                                if (reversedIndex < 0 || reversedIndex >= controller.graphData.length) return SizedBox();

                                String date = controller.graphData[reversedIndex]['date']; // Assuming format YYYY-MM-DD
                                int month = int.parse(date.substring(5, 7));
                                String day = date.substring(8); // Get day part

                                return Text(
                                  "${_getMonthShortName(month)} $day",  // Example: Apr 15
                                  style: TextStyle(fontSize: 10.sp),
                                );
                              }

                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40, // Adjust width of the area for labels
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8), // Increase this for more space
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              );
                            },
                          ),
                        ),

                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        if (controller.showPlatinum.value)
                          LineChartBarData(
                            spots: controller.graphData.asMap().entries.map((
                              e,
                            ) {
                              final reversedX =
                                  (controller.graphData.length - 1 - e.key)
                                      .toDouble();
                              return FlSpot(
                                reversedX,
                                double.parse(e.value['platinum_price']),
                              );
                            }).toList(),
                            isCurved: true,
                            color: Colors.amber.shade700,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.amber.shade700.withOpacity(0.2),
                            ),
                            dotData: FlDotData(show: false),
                          ),
                        if (controller.showPalladium.value)
                          LineChartBarData(
                            spots: controller.graphData.asMap().entries.map((
                              e,
                            ) {
                              final reversedX =
                                  (controller.graphData.length - 1 - e.key)
                                      .toDouble();
                              return FlSpot(
                                reversedX,
                                double.parse(e.value['palladium_price']),
                              );
                            }).toList(),
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                            dotData: FlDotData(show: false),
                          ),
                        if (controller.showRhodium.value)
                          LineChartBarData(
                            spots: controller.graphData.asMap().entries.map((
                              e,
                            ) {
                              final reversedX =
                                  (controller.graphData.length - 1 - e.key)
                                      .toDouble();
                              return FlSpot(
                                reversedX,
                                double.parse(e.value['rhodium_price']),
                              );
                            }).toList(),
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.green.withOpacity(0.2),
                            ),
                            dotData: FlDotData(show: false),
                          ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.showPlatinum.value &&
                            controller.showPalladium.value == false &&
                            controller.showRhodium.value == false)
                          return;
                        controller.togglePlatinum();
                      },
                      child: Text(
                        "Platinum",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: controller.showPlatinum.value
                              ? Colors.amber.shade700
                              : Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.showPalladium.value &&
                            controller.showPlatinum.value == false &&
                            controller.showRhodium.value == false)
                          return;
                        controller.togglePalladium();
                      },
                      child: Text(
                        "Palladium",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: controller.showPalladium.value
                              ? Colors.blue
                              : Colors.brown,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        if (controller.showRhodium.value &&
                            controller.showPlatinum.value == false &&
                            controller.showPalladium.value == false)
                          return;
                        controller.toggleRhodium();
                      },
                      child: Text(
                        "Rhodium",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: controller.showRhodium.value
                              ? Colors.green
                              : Colors.brown,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "3 months +0.4%",
                      style: TextStyle(fontSize: 14.sp, color: Colors.green),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "1 year +0.5%",
                      style: TextStyle(fontSize: 14.sp, color: Colors.green),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "5 years",
                      style: TextStyle(fontSize: 14.sp, color: Colors.green),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "All",
                      style: TextStyle(fontSize: 14.sp, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
