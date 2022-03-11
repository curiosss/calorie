import 'dart:convert';

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
  List<List<Product>> eatings = [[], [], [], []];
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

  Future<bool> initTodayMeals() async {}

  Future<bool> addMealListData(
      {@required int mealType, @required Product product}) async {
    try {
      eatings[mealType].add(product);
      notifyListeners();
      print('encoded json: ${json.encode(eatings)}');
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeMealListData(
      {@required int mealType, @required int index}) async {
    try {
      eatings[mealType].removeAt(index);
      notifyListeners();
      print('encoded json: ${json.encode(eatings)}');
    } catch (e) {
      print(e);
      return false;
    }
  }
}
