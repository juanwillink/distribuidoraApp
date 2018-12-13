class AnyImage {
  int id;
  String imageDescription;
  String imageURL;
  String title;
  String alt;
  int productId;

  AnyImage({
    this.id,
    this.imageDescription,
    this.imageURL,
    this.title,
    this.alt,
    this.productId
  });

  factory AnyImage.fromJson(Map<String, dynamic> json) {
    return AnyImage(
      id: json['id'],
      imageDescription: json['any_image_description'],
      imageURL: json['any_image_url'],
      title: json['any_image_name'],
      alt: json['any_image_alt'],
      productId: int.parse(json['product_id'])
    );
  }
}