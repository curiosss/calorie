import 'package:calorie_calculator/models/calorie_model.dart';

class Ccalculator{
 static double calculateCalorie(CalorieModel calorieModel){
    double genderValue=5;
    if(calorieModel.isMen) genderValue=5;else genderValue=-161;
    double cal=(10*calorieModel.weightInKg+6.25*calorieModel.heightInCm-5*calorieModel.age+genderValue)*calorieModel.activityIndex;
    return cal??0;
  }



//    For men: BMR = 10 x weight (kg) + 6.25 x height (cm) – 5 x age (years) + 5

//    For women: BMR = 10 x weight (kg) + 6.25 x height (cm) – 5 x age (years) – 161
}