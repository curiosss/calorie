import 'dart:convert';

import 'package:calorie_calculator/models/calorie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _userName = 'userName';
  static final String _phone = 'phone';
  static final String CALARIEDATA = 'CALORIEDATA';

  static setUserDetails({String name, String phoneNum}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_userName, name);
    prefs.setString(_phone, phoneNum);
  }

  static Future<bool> setCalData({@required CalorieModel calorieModel}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(CALARIEDATA, json.encode(calorieModel.toJson()));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<CalorieModel> getCalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(CALARIEDATA);
    if (val == null) return null;
    return CalorieModel.fromJson(json.decode(val));
  }

  // static storeVersion(String version) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (version != null) {
  //     prefs.setString(_version, version);
  //   }
  // }

  // static checkVersion() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_version);
  // }
}
