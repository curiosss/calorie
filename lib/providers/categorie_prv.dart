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

  Future<bool> deleteCategory({@required int catId}) async {
    bool res = await DB.instance.deleteCategory(catId: catId);

    if (res) {
      categories.removeWhere((element) => element.id == catId);
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

  Future<bool> deleteProduct({@required int id}) async {
    print('delete product id: $id');
    bool res = await DB.instance.deleteProduct(productId: id);
    if (res) {
      products.removeWhere((element) => element.id == id);
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
