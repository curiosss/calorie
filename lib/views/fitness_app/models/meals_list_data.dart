import 'package:calorie_calculator/models/product_model.dart';

class MealsListData {
  MealsListData({
    this.typeId,
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kcal = 0,
  });

  int typeId;
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<Product> meals;
  int kcal;

  static List<MealsListData> standardMeals = <MealsListData>[
    MealsListData(
      typeId: 0,
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Ertirlik',
      kcal: 0,
      meals: [],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      typeId: 1,
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Günortan',
      kcal: 0,
      meals: [],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      typeId: 2,
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Garbanyş',
      kcal: 0,
      meals: [],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      typeId: 3,
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Agşamlyk',
      kcal: 0,
      meals: [],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
