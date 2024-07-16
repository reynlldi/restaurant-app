import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';

class CustomAppbar extends StatelessWidget {
  final Widget body;

  const CustomAppbar({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _buildShortAppbar(context),
          ],
        ),
      ),
    );
  }

  Padding _buildShortAppbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
