import 'package:restaurant_app/data/model/list_restaurant_model.dart';
import 'package:restaurant_app/data/model/search_restaurant_model.dart';

class SearchRestaurantConverter {
  static ListRestaurant toListRestaurant(SearchRestaurant searchRestaurant) {
    return ListRestaurant(
      id: searchRestaurant.id,
      name: searchRestaurant.name,
      description: searchRestaurant.description,
      pictureId: searchRestaurant.pictureId,
      city: searchRestaurant.city,
      rating: searchRestaurant.rating,
    );
  }
}
