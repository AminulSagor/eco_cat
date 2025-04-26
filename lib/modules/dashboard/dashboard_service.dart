import 'package:dio/dio.dart';
import '../../storage/token_storage.dart';

class DashboardService {
  static Future<Map<String, dynamic>> getGraphData(int days) async {
    try {
      final dio = Dio();
      String url = 'https://nlrcatalysts.com/api/get_metal_prices.php?days=$days';

      if (days > 10) {
        final token = await TokenStorage.getToken();
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await dio.get(url);
      if (response.data['status'] == 'success') {
        return response.data; // Return full response map
      } else {
        return {}; // Return empty map on failure
      }
    } catch (e) {
      print('Error fetching graph data: $e');
      return {};
    }
  }
}
