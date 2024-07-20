import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:restaurant_app/ui/detail_screen.dart';

class CardListRestaurant extends StatelessWidget {
  final ListRestaurant listRestaurant;

  const CardListRestaurant({super.key, required this.listRestaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: listRestaurant.id);
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${listRestaurant.pictureId}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    listRestaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 24,
                      ),
                      Text(
                        listRestaurant.city,
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
                        size: 18,
                      ),
                      Text(
                        listRestaurant.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
