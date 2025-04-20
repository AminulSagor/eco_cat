// lib/modules/brands/brand_controller.dart
import 'package:get/get.dart';
import 'brand_model.dart';
import 'brand_service.dart';

class BrandController extends GetxController {
  final brandService = BrandService();

  var brands = <BrandModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBrands();
  }

  void loadBrands() async {
    isLoading.value = true;
    final result = await brandService.fetchBrands();
    brands.value = result;
    isLoading.value = false;
  }
}
