import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _detailRestaurantResult;
  late ResultState _state;
  String _message = "";

  DetailRestaurantResult get result => _detailRestaurantResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailRestaurant(id);
      if (detailRestaurant.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Error $e";
    }
  }

  Future<dynamic> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      await apiService.addReview(
        id: id,
        name: name,
        review: review,
      );
      await fetchDetailRestaurant(id);
      return ResultState.success;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = "Error $e";
    }
  }
}
