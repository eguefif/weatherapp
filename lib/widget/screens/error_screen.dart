import 'package:flutter/material.dart';
import 'package:module03/models/weather_data.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(data.error["msg"],
              style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
