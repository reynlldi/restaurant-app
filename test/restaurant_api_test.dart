import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

import 'restaurant_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Test ApiService", () {
    final clientApi = MockClient();
    final apiService = ApiService(clientApi);

    test("Verify json parsing restaurant API", () async {
      final responseJson = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description":
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };

      when(clientApi.get(Uri.parse("https://restaurant-api.dicoding.dev/list")))
          .thenAnswer(
              (_) async => http.Response(json.encode(responseJson), 200));

      expect(await apiService.getListRestaurant(), isA<ListRestaurantResult>());
    });

    test("Verify json parsing detail restaurant API", () async {
      const String id = "rqdv5juczeskfw1e867";

      final responseJson = {
        "error": false,
        "message": "success",
        "restaurant": {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
          "city": "Medan",
          "address": "Jln. Pandeglang no 19",
          "pictureId": "14",
          "categories": [
            {"name": "Italia"},
            {"name": "Modern"}
          ],
          "menus": {
            "foods": [
              {"name": "Paket rosemary"},
              {"name": "Toastie salmon"}
            ],
            "drinks": [
              {"name": "Es krim"},
              {"name": "Sirup"}
            ]
          },
          "rating": 4.2,
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            }
          ]
        }
      };

      when(clientApi
              .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id")))
          .thenAnswer(
              (_) async => http.Response(json.encode(responseJson), 200));

      expect(await apiService.getDetailRestaurant(id),
          isA<DetailRestaurantResult>());
    });

    test("Verify json parsing search restaurant API", () async {
      const String query = "Makan mudah";

      final responseJson = {
        "error": false,
        "founded": 1,
        "restaurants": [
          {
            "id": "fnfn8mytkpmkfw1e867",
            "name": "Makan mudah",
            "description":
                "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
            "pictureId": "22",
            "city": "Medan",
            "rating": 3.7
          }
        ]
      };

      when(clientApi.get(
              Uri.parse("https://restaurant-api.dicoding.dev/search?q=$query")))
          .thenAnswer(
              (_) async => http.Response(json.encode(responseJson), 200));

      expect(await apiService.getSearchRestaurant(query),
          isA<SearchRestaurantResult>());
    });
  });
}
