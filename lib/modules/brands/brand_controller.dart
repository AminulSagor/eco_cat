import 'package:get/get.dart';
import 'brand_service.dart';

class BrandController extends GetxController {
  final BrandService _service = BrandService();

  var brands = [].obs;
  var subBrandsMap = {}.obs; // {brandId: subBrands}
  var modelsMap = {}.obs; // {subBrandId: models}
  var isLoading = true.obs;
  var expandedIndex = (-1).obs; // Track expanded brand index
  var expandedSubBrandId = ''.obs; // Track which sub-brand is expanded


  @override
  void onInit() {
    super.onInit();
    loadBrands();
  }

  void loadBrands() async {
    try {
      isLoading.value = true;
      brands.value = await _service.fetchBrands();
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSubBrands(String brandId, int index) async {
    // If the same index is tapped, collapse it
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;

      // Load sub-brands only if not already loaded
      if (!subBrandsMap.containsKey(brandId)) {
        final subBrands = await _service.fetchSubBrands(brandId);
        subBrandsMap[brandId] = subBrands;
      }
    }
  }


  void toggleModels(String subBrandId) async {
    if (expandedSubBrandId.value == subBrandId) {
      expandedSubBrandId.value = ''; // Collapse models
    } else {
      expandedSubBrandId.value = subBrandId;

      if (!modelsMap.containsKey(subBrandId)) {
        final models = await _service.fetchModels(subBrandId);
        modelsMap[subBrandId] = models;
      }
    }
  }

}
