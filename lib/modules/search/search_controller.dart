import 'package:eco_cat/modules/search/search_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final SearchService _service = SearchService();
  var isLoading = false.obs;
  var models = [].obs;
  var productDetails = {}.obs;
  var loginRequired = false.obs; // 👈 Add this observable

  Future<void> searchReference({String? modelName, String? productCode, String? token}) async {
    if (productCode != null && (token == null || token.isEmpty)) {
      loginRequired.value = true; // 👈 Trigger login card
      return;
    } else {
      loginRequired.value = false; // 👈 Hide login card
    }

    try {
      isLoading.value = true;
      final response = await _service.searchByReference(
        modelName: modelName,
        productCode: productCode,
        token: token,
      );

      if (response.data['status'] == 'success') {
        if (modelName != null) {
          models.value = response.data['models'];
          productDetails.value = {};
        } else if (productCode != null) {
          productDetails.value = response.data['product_details'];
          models.value = [];
        }
      } else {
        models.clear();
        productDetails.clear();
      }
    } catch (e) {
      models.clear();
      productDetails.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
