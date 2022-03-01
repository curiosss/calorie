class CalorieModel {
  bool isMen;
  int weightInKg;
  int heightInCm;
  int age;
  double activityIndex;
  double recomendCal;

  CalorieModel({
    this.isMen = true,
    this.weightInKg = 0,
    this.heightInCm = 0,
    this.age = 0,
    this.activityIndex = 1,
    this.recomendCal = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'ismen': isMen,
      'weightInKg': weightInKg,
      'heightInCm': heightInCm,
      'age': age,
      'activityIndex': activityIndex,
      'recomendcal': recomendCal,
    };
  }

  factory CalorieModel.fromJson(Map<String, dynamic> json) {
    return CalorieModel(
      isMen: json['ismen'] ?? true,
      weightInKg: json['weightInKg'] ?? 0,
      heightInCm: json['heightInCm'] ?? 0,
      age: json['age'] ?? 0,
      activityIndex: json['activityIndex'] ?? 1,
      recomendCal: json['recomendcal'] ?? 0,
    );
  }
}
