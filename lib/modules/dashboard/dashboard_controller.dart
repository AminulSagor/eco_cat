import 'package:get/get.dart';
import '../../storage/token_storage.dart';
import 'dashboard_service.dart';

class DashboardController extends GetxController {
  var selectedFilter = "5 days".obs;
  var graphData = [].obs;
  var isLoading = false.obs;

  // Toggle states
  var showPlatinum = true.obs;
  var showPalladium = true.obs;
  var showRhodium = true.obs;

  // Metal increase percentages
  var platinumIncrease = "".obs;
  var palladiumIncrease = "".obs;
  var rhodiumIncrease = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchGraphData();
  }

  void onFilterSelected(String label) async {
    if (label != "5 days") {
      final token = await TokenStorage.getToken();
      if (token == null) {
        Get.defaultDialog(
          title: "Login Required",
          middleText: "Please log in to access data beyond 10 days.",
          textCancel: "Cancel",
          textConfirm: "Login",
          onConfirm: () {
            Get.back();
            Get.offAllNamed('/login');
          },
        );
        return;
      }
    }
    selectedFilter.value = label;
    fetchGraphData();
  }

  void fetchGraphData() async {
    isLoading.value = true;
    int days = getDaysFromFilter(selectedFilter.value);
    final response = await DashboardService.getGraphData(days);

    if (response.isNotEmpty) {
      graphData.value = response['metal_prices'] ?? [];

      // Update increases dynamically
      platinumIncrease.value = response['platinumIncrease'] ?? "0.00%";
      palladiumIncrease.value = response['palladiumIncrease'] ?? "0.00%";
      rhodiumIncrease.value = response['rhodiumIncrease'] ?? "0.00%";
    } else {
      graphData.clear();
      platinumIncrease.value = "0.00%";
      palladiumIncrease.value = "0.00%";
      rhodiumIncrease.value = "0.00%";
    }
    isLoading.value = false;
  }

  int getDaysFromFilter(String filter) {
    switch (filter) {
      case "5 days":
        return 5;
      case "3 months":
        return 90;
      case "1 year":
        return 365;
      case "5 years":
        return 1825;
      default:
        return 0;
    }
  }

  // Toggle functions
  void togglePlatinum() => showPlatinum.value = !showPlatinum.value;
  void togglePalladium() => showPalladium.value = !showPalladium.value;
  void toggleRhodium() => showRhodium.value = !showRhodium.value;
}
