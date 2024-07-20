import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  SearchRestaurantResult? _restaurantSearchResult;
  ResultState? _state;
  String _message = '';

  String get message => _message;
  SearchRestaurantResult? get result => _restaurantSearchResult;
  ResultState? get state => _state;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.getSearchRestaurant(query);
      if (restaurantSearch.founded == 0 &&
          restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Pencarian Tidak Ditemukan';
      } else {
        _restaurantSearchResult = restaurantSearch;
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void clearSearchResults() {
    _restaurantSearchResult = null;
    _state = null;
    notifyListeners();
  }
}
