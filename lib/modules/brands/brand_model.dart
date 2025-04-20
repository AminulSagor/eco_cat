class BrandModel {
  final String id;
  final String name;
  final String label;
  final String image;

  BrandModel({
    required this.id,
    required this.name,
    required this.label,
    required this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'].toString(),
      name: json['brand_name'],
      label: "${json['brand_name']} Parts Price",
      image: json['image_path'],
    );
  }
}
