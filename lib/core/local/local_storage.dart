import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _preferences;

  LocalStorage._init() {
    _instance = this;
  }

  static LocalStorage get instance {
    if (_instance == null) {
      LocalStorage._init();
    }
    return _instance!;
  }

  Future<SharedPreferences?> initSharedPreferences() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setShowOnboard({required bool isShowOnboard}) async {
    await _preferences?.setBool('showOnboard', isShowOnboard);
  }

  bool? getShowOnboard() {
    return _preferences?.getBool('showOnboard');
  }
}
