// lib/modules/model/model_model.dart
class ModelItem {
  final String id;
  final String name;
  final String subBrandId;

  ModelItem({
    required this.id,
    required this.name,
    required this.subBrandId,
  });

  factory ModelItem.fromJson(Map<String, dynamic> json) {
    return ModelItem(
      id: json['id'],
      name: json['model'],
      subBrandId: json['subBrand_id'],
    );
  }
}
