import 'package:distribuidora/model/Color.dart';
import 'package:distribuidora/model/ProductType.dart';
import 'package:distribuidora/model/AnyImage.dart';
import 'package:distribuidora/model/Color.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  double salePrice;
  Color color;
  ProductType productType;
  List<AnyImage> images;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.salePrice,
    this.color,
    this.productType,
    this.images
  });

  factory Product.fromJson(Map<String, dynamic> json) {

    var list = json['images'] as List;

    List<AnyImage> imageList = list.map((i) => AnyImage.fromJson(i)).toList();

    return Product(
      id: json['id'] as int,
      name: json['product_name'] as String,
      description: json['product_description'] as String,
      price: double.parse(json['product_price']),
      salePrice: (json['product_sale_price'] != null) ? double.parse(json['product_sale_price']) : null,
      color: Color.fromJson(json['color']),
      productType: ProductType.fromJson(json['product_type']),
      images: imageList
    );
  }

  @override
  toString() => "id: $id, description: $description";
}