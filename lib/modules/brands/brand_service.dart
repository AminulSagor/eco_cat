import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandService extends GetxService {
  final String baseUrl = 'https://nlrcatalysts.com/api';

  Future<List<dynamic>> fetchBrands() async {
    final response = await http.get(Uri.parse('$baseUrl/get_all_brand.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['events'];
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<List<dynamic>> fetchSubBrands(String brandId) async {
    final response = await http.get(Uri.parse('$baseUrl/get_subBrand_by_brand.php?brand_id=$brandId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['events'];
    } else {
      throw Exception('Failed to load sub-brands');
    }
  }

  Future<List<dynamic>> fetchModels(String subBrandId) async {
    final response = await http.get(Uri.parse('$baseUrl/get_model_by_subBrand.php?subBrand_id=$subBrandId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['models'];
    } else {
      throw Exception('Failed to load models');
    }
  }
}
