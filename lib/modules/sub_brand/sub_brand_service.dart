// lib/modules/sub_brand/sub_brand_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubBrandService {
  Future<List<Map<String, dynamic>>> fetchSubBrands(String brandId) async {
    final url = Uri.parse('https://www.nlrcatalysts.com/api/get_subBrand_by_brand.php?brand_id=$brandId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        return (body['events'] as List).map<Map<String, dynamic>>((item) {
          return {
            'id': item['id'],
            'name': item['name'],
            'brand_id': item['brand_id'],
          };
        }).toList();
      }
    }
    return [];
  }
}
