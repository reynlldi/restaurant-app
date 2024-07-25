import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/ui/favorite_screen.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/ui/setting_screen.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';
import 'package:restaurant_app/widget/error_message.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<ListRestaurantProvider>(context, listen: false)
        .fetchAllListRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) => ListRestaurantProvider(
        apiService: ApiService(http.Client()),
      ),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Restaurant",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SearchScreen.routeName);
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, FavoriteScreen.routeName);
                          },
                          icon: const Icon(Icons.favorite_border),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SettingScreen.routeName);
                          },
                          icon: const Icon(Icons.settings),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Recommendation restaurant for you!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildRestaurantList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    return Consumer<ListRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: Center(
              child: CircularProgressIndicator(color: Colors.green[800]),
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var listRestaurant = state.result.restaurants[index];
                return CardListRestaurant(listRestaurant: listRestaurant);
              },
            ),
          );
        } else if (state.state == ResultState.noData) {
          return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: const ErrorMessage(
                    image: "assets/images/no_data.png",
                    message: "Data is empty, please refresh again",
                  ),
                )
              ],
            ),
          );
        } else if (state.state == ResultState.error) {
          return RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: const ErrorMessage(
                    image: "assets/images/no_internet.png",
                    message:
                        "Check your internet connection and refresh this page",
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(""),
            ),
          );
        }
      },
    );
  }
}
