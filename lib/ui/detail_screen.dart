import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/widget/custom_appbar.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail_screen";
  final Restaurant restaurant;

  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.network("${restaurant.pictureId}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${restaurant.name}",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 24,
                      ),
                      Text(
                        "${restaurant.city}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Deskripsi :",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${restaurant.description}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Our Menu :",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Foods",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurant.menus!.foods!.map((foods) {
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/food.png",
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${foods.name}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "Rp 25.000",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Drinks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurant.menus!.drinks!.map((drinks) {
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/drink.png",
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${drinks.name}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "Rp 20.000",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
