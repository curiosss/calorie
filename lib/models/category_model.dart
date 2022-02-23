class Category {
  final int id;
  String catName;
  String image;
  Category({
    this.id,
    this.catName = '',
    this.image = '',
  });

  factory Category.fromMap(Map<String, dynamic> json) {
    print(json);
    return Category(
      id: json['id'] ?? 0,
      catName: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Category.copyWith(this.id, {String title, String image}) {
    this.catName = title;
    this.image = image;
  }
}
