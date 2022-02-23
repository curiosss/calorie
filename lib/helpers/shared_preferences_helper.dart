import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _userName = 'userName';
  static final String _phone = 'phone';
  static final String _version = 'version';
  static final String fcmToken = 'fcmToken';

  static setUserDetails({String name, String phoneNum}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_userName, name);
    prefs.setString(_phone, phoneNum);
  }

  static storeVersion(String version) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (version != null) {
      prefs.setString(_version, version);
    }
  }

  static checkVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_version);
  }
}
