import 'package:get/get.dart';
import '../../storage/token_storage.dart';
import 'product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();
  var products = [].obs;
  var isLoading = false.obs;
  var productDetails = {}.obs;

  void loadProducts(String modelId) async {
    isLoading.value = true;
    products.value = await _service.fetchProducts(modelId);
    isLoading.value = false;
  }

  Future<void> loadProductDetails(String productId) async {
    // 🔒 Check login before loading details
    final token = await TokenStorage.getToken();
    if (token == null) {
      Get.defaultDialog(
        title: "Login Required",
        middleText: "Please log in to access product details.",
        textCancel: "Cancel",
        textConfirm: "Login",
        onConfirm: () {
          Get.back();
          Get.offAllNamed('/login');
        },
      );
      return;
    }

    // 🚀 Load details if logged in
    isLoading.value = true;
    final product = await _service.fetchProductById(productId);
    if (product != null) {
      productDetails.value = product;
    }
    isLoading.value = false;
  }
}
