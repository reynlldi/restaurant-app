import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';
import 'package:restaurant_app/widget/error_message.dart';
import 'package:restaurant_app/widget/search_restaurant_converter.dart';
import 'package:restaurant_app/widget/search_text_field.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/search_screen";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      builder: (context, _) {
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: const Text("Search"),
            backgroundColor: primaryColor,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const SearchTextField(),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _buildSearchList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchList() {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, __) {
        if (state.state == ResultState.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green[800],
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result?.restaurants.length,
            itemBuilder: (context, index) {
              var searchRestaurant = state.result?.restaurants[index];
              final listRestaurant =
                  SearchRestaurantConverter.toListRestaurant(searchRestaurant!);
              return CardListRestaurant(listRestaurant: listRestaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return const Center(
            child: ErrorMessage(
              image: "assets/images/no_data.png",
              message: "Data is empty, please refresh again",
            ),
          );
        } else if (state.state == ResultState.error) {
          return const Center(
            child: ErrorMessage(
              image: "assets/images/no_internet.png",
              message: "Check your internet connection and refresh this page",
            ),
          );
        } else {
          return Center(
            child: Text(
              "Find your best restaurant of choice!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
      },
    );
  }
}
