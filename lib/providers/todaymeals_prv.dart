import 'package:calorie_calculator/helpers/db_helper.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:calorie_calculator/views/fitness_app/models/meals_list_data.dart';
import 'package:flutter/cupertino.dart';

class TodayMealsProvider with ChangeNotifier {
  double shouldEatCal = 0;
  double eatenCal = 0;
  double leftCal = 0;
  double totalBelok = 0;
  double totalYaglar = 0;
  double totalUglewodlar = 0;
  double water = 0;
  List<MealsListData> eatings = MealsListData.standardMeals;
  List<Product> products = [];

  Future<List<Product>> initSelectableProducts() async {
    try {
      products = await DB.instance.getAllProducts();
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
