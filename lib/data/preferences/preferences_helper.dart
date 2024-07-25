import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const activeNotification = "ACTIVE_NOTIFICATION";

  Future<bool> get isActiveNotification async {
    final prefs = await sharedPreferences;
    return prefs.getBool(activeNotification) ?? false;
  }

  Future<void> setActiveNotification(bool value) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(activeNotification, value);
  }
}
