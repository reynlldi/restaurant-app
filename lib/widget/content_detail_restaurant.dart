import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_model.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/widget/content_review.dart';

class ContentDetailRestaurant extends StatelessWidget {
  final DetailRestaurant detailRestaurant;

  const ContentDetailRestaurant({super.key, required this.detailRestaurant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/${detailRestaurant.pictureId}"),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  detailRestaurant.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.place,
                      color: Colors.red,
                      size: 24,
                    ),
                    Text(
                      "${detailRestaurant.address}, ${detailRestaurant.city}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 24,
                    ),
                    Text(
                      detailRestaurant.rating.toString(),
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
                  detailRestaurant.description,
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
                    children: detailRestaurant.menus.foods.map((foods) {
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
                                foods.name,
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
                    children: detailRestaurant.menus.drinks.map((drinks) {
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
                                drinks.name,
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
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Reviews",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider<
                                DetailRestaurantProvider>(
                              create: (context) => DetailRestaurantProvider(
                                apiService: ApiService(),
                                id: detailRestaurant.id,
                              ),
                              child: ContentReview(
                                id: detailRestaurant.id,
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Add review",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: secondaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: detailRestaurant.customerReviews.map((review) {
                      return SizedBox(
                        width: 300,
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  review.review,
                                  style: Theme.of(context).textTheme.bodySmall!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  review.date,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
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
    );
  }
}
