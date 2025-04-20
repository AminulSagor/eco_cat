class ProductItem {
  final String id;
  final String name;
  final String weight;
  final String rhodiumWeight;
  final String palladiumWeight;
  final String platinumWeight;
  final String code;
  final String image;
  final String price;

  ProductItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.rhodiumWeight,
    required this.palladiumWeight,
    required this.platinumWeight,
    required this.code,
    required this.image,
    required this.price,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id']?.toString() ?? '',
      name: json['product_name'] ?? '',
      weight: json['weight'] ?? '',
      rhodiumWeight: json['rhodium_weight'] ?? '',
      palladiumWeight: json['palladium_weight'] ?? '',
      platinumWeight: json['platinum_weight'] ?? '',
      code: json['code'] ?? '',
      image: json['img_path'] ?? '', // ✅ fixed here
      price: json['price']?.toString() ?? '0',
    );
  }

}
