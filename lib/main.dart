import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // or whatever your design is based on
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData.light(), // you had ThemeData.dark()
      ),
    ),
  );
}
