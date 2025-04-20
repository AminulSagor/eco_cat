// lib/modules/brands/brand_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'brand_model.dart';

class BrandService {
  Future<List<BrandModel>> fetchBrands() async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl/get_all_brand.php');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        return (body['events'] as List)
            .map((item) => BrandModel.fromJson(item))
            .toList();
      }
    }

    return [];
  }
}
