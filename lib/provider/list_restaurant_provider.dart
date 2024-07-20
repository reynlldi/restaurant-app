import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    fetchAllListRestaurant();
  }

  late ListRestaurantResult _listRestaurantResult;
  late ResultState _state;
  String _message = "";

  ListRestaurantResult get result => _listRestaurantResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurant = await apiService.getListRestaurant();
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurantResult = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }
}
