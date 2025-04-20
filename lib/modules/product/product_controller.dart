// lib/modules/product/product_controller.dart
import 'package:get/get.dart';
import 'product_model.dart';
import 'product_service.dart';

class ProductController extends GetxController {
  final productService = ProductService();

  var products = <ProductItem>[].obs;
  var isLoading = false.obs;

  void loadProducts(String modelId) async {
    isLoading.value = true;
    final result = await productService.fetchProductsByModel(modelId);
    products.value = result;
    isLoading.value = false;
  }
}
