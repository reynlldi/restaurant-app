import 'dart:convert';

import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/review_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class ApiService {
  final http.Client client;
  ApiService(this.client);

  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<ListRestaurantResult> getListRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return ListRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load list restaurant");
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load detail restaurant");
    }
  }

  Future<SearchRestaurantResult> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load search restaurant");
    }
  }

  Future<ReviewRestaurantResult> addReview({
    required String id,
    required String name,
    required String review,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      return ReviewRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load review restaurant');
    }
  }
}
