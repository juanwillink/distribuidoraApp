class Color {
  int id;
  String name;

  Color({
    this.id,
    this.name
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      id: json['id'] as int,
      name: json['color_name'] as String
    );
  }
}