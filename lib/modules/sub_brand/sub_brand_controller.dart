// lib/modules/sub_brand/sub_brand_controller.dart
import 'package:get/get.dart';
import 'sub_brand_service.dart';

class SubBrandController extends GetxController {
  final subBrandService = SubBrandService();
  var subBrands = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  void loadSubBrands(String brandId) async {
    isLoading.value = true;
    final result = await subBrandService.fetchSubBrands(brandId);
    subBrands.value = result;
    isLoading.value = false;
  }
}
