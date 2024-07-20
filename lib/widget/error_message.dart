import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String image;
  final String message;

  const ErrorMessage({super.key, required this.image, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          width: 200,
          height: 150,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
