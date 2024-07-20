import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        Provider.of<SearchRestaurantProvider>(context, listen: false)
            .fetchSearchRestaurant(query);
      } else {
        Provider.of<SearchRestaurantProvider>(context, listen: false)
            .clearSearchResults();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: InputBorder.none,
        hintText: 'Search your favorite restaurant',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
      maxLines: 1,
      onChanged: _onSearchChanged,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
