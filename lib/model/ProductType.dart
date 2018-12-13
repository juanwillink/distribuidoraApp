class ProductType {
  int id;
  String name;
  String description;

  ProductType({
    this.id,
    this.name,
    this.description
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'] as int,
      name: json['product_type_name'] as String,
      description: json['product_type_description'] as String
    );
  }
}