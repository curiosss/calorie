import 'dart:convert';
import 'package:calorie_calculator/helpers/db_helper.dart';
import 'package:calorie_calculator/helpers/shared_preferences_helper.dart';
import 'package:calorie_calculator/models/calorie_model.dart';
import 'package:calorie_calculator/models/menus_model.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayMealsProvider with ChangeNotifier {
  double shouldEatCal = 2000;
  String lastDrinkDate = '';
  double eatenCal = 0;
  double leftCal = 0;
  int totalBelok = 0, ratioBelok = 0;
  int totalYaglar = 0, ratioYag = 0;
  int totalUglewodlar = 0, ratioUglewod = 0;

  int water = 0;
  final int SHOULDDRINK = 3000;
  List<List<Product>> eatings = [[], [], [], []];
  List<double> totalEatingCal = [0, 0, 0, 0];
  List<Product> selectableProducts = [];
  MenusModel menusModel;

  Future<List<Product>> initSelectableProducts() async {
    try {
      selectableProducts = await DB.instance.getAllProducts();
      return selectableProducts;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> initTodayMeals() async {
    try {
      CalorieModel calorieModel = await SharedPreferencesHelper.getCalData();
      if (calorieModel != null && calorieModel.recomendCal != null) {
        shouldEatCal = calorieModel.recomendCal;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      lastDrinkDate = prefs.getString('lastdate') ?? '';

      String today = DateFormat('yyyy.MM.dd').format(DateTime.now());
      menusModel = await DB.instance.getTodayMenu(date: today);
      if (menusModel == null) {
        menusModel = MenusModel(
          id: DateTime.now().millisecondsSinceEpoch,
          date: today,
          meals: json.encode(eatings),
          water: water,
        );
        await DB.instance.createTodayMenu(menusModel);
      } else {
        eatings = List.from(json.decode(menusModel.meals).map((list) {
          return List<Product>.from(list.map((product) {
            return Product.fromMap(product);
          }));
        }));
        calculateTotalCalories();
        water = menusModel.water;
        notifyListeners();
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

  Future<bool> addMealListData(
      {@required int mealType, @required Product product}) async {
    try {
      eatings[mealType].add(product);
      updateMealsInDb();
      notifyListeners();
      print('encoded json: ${json.encode(eatings)}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> removeMealListData({
    @required int mealType,
    @required int index,
  }) async {
    try {
      eatings[mealType].removeAt(index);
      updateMealsInDb();
      notifyListeners();
      print('encoded json: ${json.encode(eatings)}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  changeWater({int val = 0}) async {
    water += val;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastDrinkDate = DateFormat('HH:mm').format(DateTime.now());
    prefs.setString('lastdate', lastDrinkDate);
    notifyListeners();
    updateMealsInDb(shuldCalculate: false);
  }

  updateMealsInDb({bool shuldCalculate = true}) {
    if (shuldCalculate) calculateTotalCalories();
    menusModel.water = water;
    menusModel.meals = json.encode(eatings);
    DB.instance.updateTodayMenu(menusModel);
  }
}
