import 'dart:convert';
import 'package:calorie_calculator/helpers/db_helper.dart';
import 'package:calorie_calculator/helpers/shared_preferences_helper.dart';
import 'package:calorie_calculator/models/calorie_model.dart';
import 'package:calorie_calculator/models/menus_model.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HistoryProvider with ChangeNotifier {
  double shouldEatCal = 2000;

  double eatenCal = 0;
  double leftCal = 0;
  int totalBelok = 0, ratioBelok = 0;
  int totalYaglar = 0, ratioYag = 0;
  int totalUglewodlar = 0, ratioUglewod = 0;

  int water = 0;
  final int SHOULDDRINK = 3000;
  List<List<Product>> eatings = [[], [], [], []];
  List<double> totalEatingCal = [0, 0, 0, 0];

  MenusModel menusModel;

  Future<bool> initTodayMeals(DateTime date) async {
    try {
      CalorieModel calorieModel = await SharedPreferencesHelper.getCalData();
      if (calorieModel != null && calorieModel.recomendCal != null) {
        shouldEatCal = calorieModel.recomendCal;
      }

      String today = DateFormat('yyyy.MM.dd').format(date);
      menusModel = await DB.instance.getTodayMenu(date: today);
      if (menusModel == null) {
        return false;
      } else {
        eatings = List.from(json.decode(menusModel.meals).map((list) {
          return List<Product>.from(list.map((product) {
            return Product.fromMap(product);
          }));
        }));
        calculateTotalCalories();
        water = menusModel.water;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  calculateTotalCalories() {
    eatenCal = 0;
    totalBelok = 0;
    totalYaglar = 0;
    totalUglewodlar = 0;
    for (int i = 0; i < eatings.length; i++) {
      double sum = 0;
      eatings[i].forEach((product) {
        sum += (product.calorie * product.quant / 100) ?? 0;
        totalBelok += product.protein ?? 0;
        totalYaglar += product.fat ?? 0;
        totalUglewodlar += product.carbohydrate ?? 0;
      });
      totalEatingCal[i] = sum;
      eatenCal += sum;
    }
    print('totalbelok: $totalBelok');
    leftCal = shouldEatCal - eatenCal;
    int ttsum = totalBelok + totalUglewodlar + totalYaglar;
    if (ttsum == 0) ttsum = 1;
    ratioBelok = (totalBelok / ttsum * 100).toInt();
    ratioYag = (totalYaglar / ttsum * 100).toInt();
    ratioUglewod = (totalUglewodlar / ttsum * 100).toInt();
  }
}
