import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eco_cat/modules/search/search_controller.dart' as my_search;
import '../../storage/token_storage.dart';
import '../product/product_controller.dart';
import '../product/product_details_view.dart';
import '../product/product_view.dart';

class SearchByReferenceView extends StatefulWidget {
  const SearchByReferenceView({Key? key}) : super(key: key);

  @override
  _SearchByReferenceViewState createState() => _SearchByReferenceViewState();
}

class _SearchByReferenceViewState extends State<SearchByReferenceView> {
  final my_search.SearchController controller = Get.put(my_search.SearchController());
  final TextEditingController searchController = TextEditingController();
  bool isCodeSearch = false;

  Future<void> _triggerSearch() async {
    if (searchController.text.trim().isNotEmpty) {
      String? token = isCodeSearch ? await TokenStorage.getToken() : null;

      controller.searchReference(
        modelName: isCodeSearch ? null : searchController.text.trim(),
        productCode: isCodeSearch ? searchController.text.trim() : null,
        token: token,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.green),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: isCodeSearch ? 'Search by code' : 'Search by model name',
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.done, // Done button
                onSubmitted: (_) => _triggerSearch(),  // When done button pressed
                onChanged: (value) {
                  if (value.endsWith(' ')) {  // When user presses space
                    _triggerSearch();
                  }
                },
              ),

            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.green),
              onPressed: () => _triggerSearch(),
            ),
            Switch(
              value: isCodeSearch,
              onChanged: (val) {
                setState(() => isCodeSearch = val);
              },
              activeColor: Colors.green,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.loginRequired.value) {
          // Login required card
          return Center(
            child: Card(
              margin: EdgeInsets.all(16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Login Required", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text("Please log in to search by code."),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed('/login'); // Navigate to login
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.models.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: controller.models.length,
            itemBuilder: (_, index) {
              final model = controller.models[index];
              return GestureDetector(
                onTap: () {

                  Get.to(() => ProductView(modelId: model['id'].toString()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model['model'] ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.directions_car, size: 16, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              model['subBrand_name'] ?? '',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.local_offer, size: 16, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              model['brand_name'] ?? '',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );

        }

        if (controller.productDetails.isNotEmpty) {
          final product = controller.productDetails;
          return GestureDetector(
            onTap: () {
              Get.put(ProductController()); // 👈 Initialize controller
              Get.to(() => ProductDetailsView(productId: product['id'].toString()));
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['img_path'],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Product Name
                      Text(
                        product['product_name'] ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      SizedBox(height: 12),
                      // Product details rows
                      _buildDetailRow('Weight:', product['weight']),
                      SizedBox(height: 8),
                      _buildDetailRow('Price:', product['price']),
                      SizedBox(height: 8),
                      _buildDetailRow('Code:', product['code']), // If you have this
                    ],
                  ),
                ),
              ),
            ),
          );
        }


        return Center(child: Text('No results'));
      }),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Row(
      children: [
        Icon(Icons.label_important, size: 16, color: Colors.grey[700]),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Text(
            value != null ? value.toString() : '',
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }


}
