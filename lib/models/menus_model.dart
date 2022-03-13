class MenusModel {
  int id;
  String date;
  String meals;
  double water;

  MenusModel({
    this.id,
    this.date,
    this.meals,
    this.water,
  });

  factory MenusModel.fromJson(Map<String, dynamic> json) {
    return MenusModel(
      id: json['id'],
      date: json['date'],
      meals: json['meals'],
      water: json['water'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'meals': meals,
      'water': water,
    };
  }
}
