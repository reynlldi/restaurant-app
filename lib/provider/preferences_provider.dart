import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getActiveNotification();
  }

  bool _isActiveNotification = false;
  bool get isActiveNotification => _isActiveNotification;

  void _getActiveNotification() async {
    _isActiveNotification = await preferencesHelper.isActiveNotification;
    notifyListeners();
  }

  void enabledActiveNotification(bool value) {
    preferencesHelper.setActiveNotification(value);
    _getActiveNotification();
  }
}
