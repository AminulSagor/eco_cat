// lib/modules/model/model_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'model_model.dart';

class ModelService {
  Future<List<ModelItem>> fetchModelsBySubBrand(String subBrandId) async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl/get_model_by_subBrand.php?subBrand_id=$subBrandId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        return (body['models'] as List)
            .map((item) => ModelItem.fromJson(item))
            .toList();
      }
    }
    return [];
  }
}
