class ResponseCategories {
  final String? id;
  final String? name;
  final String? image;

  ResponseCategories({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ResponseCategories.fromJson(Map<String, dynamic> json) {
    return ResponseCategories(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
