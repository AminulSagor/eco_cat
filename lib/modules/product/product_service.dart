import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../storage/token_storage.dart';

class ProductService {
  final String baseUrl = 'https://nlrcatalysts.com/api';
  final Dio _dio = Dio();
  Future<List<Map<String, dynamic>>> fetchProducts(String modelId) async {
    final response = await http.get(Uri.parse('https://nlrcatalysts.com/api/get_product_by_model.php?model_id=$modelId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return List<Map<String, dynamic>>.from(data['products']);
      }
    }
    return [];
  }

  Future<Map<String, dynamic>?> fetchProductById(String productId) async {
    final token = await TokenStorage.getToken();
    if (token == null) return null; // Not authenticated

    try {
      final response = await _dio.get(
        '$baseUrl/get_product_by_id.php?product_id=$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data['status'] == 'success') {
        return response.data['product_details'];
      }
    } catch (e) {
      print('Error fetching product: $e');
    }
    return null;
  }
}
