import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widget/content_detail_restaurant.dart';
import 'package:restaurant_app/widget/custom_appbar.dart';
import 'package:restaurant_app/widget/error_message.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  static const routeName = "/detail_screen";

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<void> _refreshData(BuildContext context) async {
    final String restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;
    await Provider.of<DetailRestaurantProvider>(context, listen: false)
        .fetchDetailRestaurant(restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    final String restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;

    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(http.Client()), id: restaurantId),
      child: CustomAppbar(
        body: _buildDetailRestaurant(),
      ),
    );
  }

  Widget _buildDetailRestaurant() {
    return Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
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
          child: ListView(
            children: [
              ContentDetailRestaurant(detailRestaurant: state.result.restaurant)
            ],
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
              )
            ],
          ),
        );
      } else {
        return const Center(
          child: Text(""),
        );
      }
    });
  }
}
