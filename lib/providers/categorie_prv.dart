import 'dart:io';

import 'package:calorie_calculator/helpers/db_helper.dart';
import 'package:calorie_calculator/helpers/shared_preferences_helper.dart';
import 'package:calorie_calculator/models/calorie_model.dart';
import 'package:calorie_calculator/models/category_model.dart';
import 'package:calorie_calculator/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CategorieProvider with ChangeNotifier {
  List<Category> categories = [];
  List<Product> products = [];
  CalorieModel calorieModel;

  Future<bool> initCats() async {
    try {
      categories = await DB.instance.getCategories() ?? [];
      print(categories);
    } catch (e) {
      print(e);
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> initProducts({@required int catid}) async {
    try {
      products = [];
      products = await DB.instance.getProducts(categoryId: catid) ?? [];
      print(products);
    } catch (e) {
      print(e);
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<CalorieModel> initCalData() async {
    try {
      calorieModel = await SharedPreferencesHelper.getCalData();
      print(calorieModel);
      return calorieModel;
    } catch (e) {
      print(e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createCategory({@required Category categoryMdl}) async {
    bool result = await DB.instance.createCategory(categoryMdl);
    if (result) {
      categories.add(categoryMdl);
      notifyListeners();
    }

    return result;
  }

  Future<bool> deleteCategory({@required Category category}) async {
    bool res = await DB.instance.deleteCategory(catId: category.id);

    if (res) {
      await File(category.image).delete();
      categories.removeWhere((element) => element.id == category.id);
      notifyListeners();
    }
    return res;
  }

  Future<bool> updateCategory({Category category}) async {
    bool res = await DB.instance.updateCategory(category: category);
    if (res) initCats();

    return res;
  }

  //product actions

  Future<bool> createProduct({@required Product product}) async {
    print(product.carbohydrate);
    bool result = await DB.instance.createProduct(product);
    if (result) {
      products.add(product);
      notifyListeners();
    }
    return result;
  }

  Future<bool> updateProduct({@required Product product}) async {
    bool res = await DB.instance.updateProduct(product: product);
    if (res) {
      initProducts(catid: product.categoryId);
    }

    return res;
  }

  Future<bool> deleteProduct({@required Product product}) async {
    print('delete product id: ${product.id}');
    bool res = await DB.instance.deleteProduct(productId: product.id);
    if (res) {
      await File(product.image).delete();
      products.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
    return res;
  }

  //profile details
  Future<bool> saveCalData(CalorieModel calorieModel) async {
    try {
      await SharedPreferencesHelper.setCalData(calorieModel: calorieModel);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
