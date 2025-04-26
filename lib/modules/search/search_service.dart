import 'package:dio/dio.dart';

class SearchService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://nlrcatalysts.com/api/'));

  Future<Response> searchByReference({
    String? modelName,
    String? productCode,
    String? token,
  }) async {
    try {
      String endpoint = 'search_by_reference.php';
      Map<String, String> params = {};

      if (modelName != null) {
        params['model_name'] = modelName;
      } else if (productCode != null) {
        params['product_code'] = productCode;
      }

      Options options = Options(
        headers: productCode != null
            ? {'Authorization': 'Bearer $token'}
            : null,
      );

      return await _dio.get(endpoint, queryParameters: params, options: options);
    } catch (e) {
      rethrow;
    }
  }
}
