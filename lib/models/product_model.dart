class Product {
  final int id;
  int categoryId;
  String name;
  int calorie;
  int protein;
  int fat;
  int carbohydrate;
  String image;
  Product({
    this.id = -1,
    this.categoryId = -1,
    this.name = '',
    this.calorie = 0,
    this.protein = 0,
    this.fat = 0,
    this.carbohydrate = 0,
    this.image = '',
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    print(json);
    return Product(
      id: json['id'],
      categoryId: json['cat_id'],
      name: json['name'],
      calorie: json['calorie'] ?? 0,
      protein: json['protein'] ?? 0,
      fat: json['fat'] ?? 0,
      carbohydrate: json['carbohydrate'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  // Product.copyWith(this.id, {String title, String image}) {
  //   this.catName = title;
  //   this.image = image;
  // }
}
