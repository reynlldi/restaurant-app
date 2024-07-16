import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant_data.dart';
import 'package:restaurant_app/ui/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _searchController.addListener(_filterRestaurants);
  }

  Future<void> _loadRestaurants() async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/local_restaurant.json");
    setState(() {
      _restaurants = parseRestaurants(data);
      _filteredRestaurants = _restaurants;
    });
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRestaurants = _restaurants.where((restaurant) {
        return restaurant.name!.toLowerCase().contains(query) ||
            restaurant.city!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Restaurant",
                style: Theme.of(context).textTheme.headlineMedium,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _searchController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Search your favorite restaurant",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _buildRestaurantList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    if (_filteredRestaurants.isEmpty) {
      return Center(
          child: Text(
        "No restaurants found!",
        style: Theme.of(context).textTheme.bodyLarge,
      ));
    } else {
      return ListView.builder(
        itemCount: _filteredRestaurants.length,
        itemBuilder: (context, index) {
          return _buildRestaurantsItem(context, _filteredRestaurants[index]);
        },
      );
    }
  }

  Widget _buildRestaurantsItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      "${restaurant.pictureId}",
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
                      "${restaurant.name}",
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
                          "${restaurant.city}",
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
                          restaurant.rating.toString(),
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
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
