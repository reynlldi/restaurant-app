import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/card_list_restaurant.dart';
import 'package:restaurant_app/widget/error_message.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = "/bookmark_screen";

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Your favorite restaurant"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (_, provider, __) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorite.length,
            itemBuilder: (_, index) {
              return CardListRestaurant(
                listRestaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return const ErrorMessage(
            image: "assets/images/no_data.png",
            message: "Favorite restaurant data is empty",
          );
        }
      },
    );
  }
}
