// lib/modules/model/model_controller.dart
import 'package:get/get.dart';
import 'model_model.dart';
import 'model_service.dart';

class ModelController extends GetxController {
  final modelService = ModelService();

  var models = <ModelItem>[].obs;
  var isLoading = false.obs;

  void loadModels(String subBrandId) async {
    isLoading.value = true;
    final result = await modelService.fetchModelsBySubBrand(subBrandId);
    models.value = result;
    isLoading.value = false;
  }
}
