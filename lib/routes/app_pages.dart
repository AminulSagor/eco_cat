import 'package:get/get.dart';

import '../modules/brands/brands_view.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_controller.dart';
import '../modules/login/login_view.dart';
import '../modules/profile/profile_view.dart';
import '../modules/signup/signup_controller.dart';
import '../modules/signup/signup_view.dart';


class AppPages {
  static const INITIAL = '/';
  static const signUp = '/sign_up';
  static const home = '/home';


  static final routes = [


    GetPage(
      name: AppPages.INITIAL,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),


    GetPage(
      name: AppPages.signUp,
      page: () => SignupView(),
      binding: BindingsBuilder(() {
        Get.put(SignupController()); // 👈 Just call it
      }),
    ),

    GetPage(
      name: home,
      page: () => HomeView(),

    ),

    // Optional: direct access to inner tabs if needed
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(name: '/brands', page: () => BrandsView()),
    GetPage(name: '/profile', page: () => ProfileView()),
  ];
}