import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = "";
  String get message => _message;

  List<ListRestaurant> _favorite = [];
  List<ListRestaurant> get favorite => _favorite;

  void _getFavorites() async {
    _favorite = await databaseHelper.getFavorites();
    if (_favorite.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = "Empty data";
    }
    notifyListeners();
  }

  void addFavorite(ListRestaurant restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error $e";
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = "Error $e";
      notifyListeners();
    }
  }
}
