import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/images/logo_app.png",
            width: 200,
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(
            "Find Your Best Restaurant",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }
}
