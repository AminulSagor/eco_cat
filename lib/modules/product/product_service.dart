// lib/modules/product/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'product_model.dart';

class ProductService {
  Future<List<ProductItem>> fetchProductsByModel(String modelId) async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl/get_product_by_model.php?model_id=$modelId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        return (body['products'] as List)
            .map((item) => ProductItem.fromJson(item))
            .toList();
      }
    }
    return [];
  }
}
