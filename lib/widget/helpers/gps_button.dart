import 'package:flutter/material.dart';


class GpsButton extends StatelessWidget {
  const GpsButton({super.key, required this.fetchWeather, required this.switchLoading});

  final void Function() fetchWeather;
  final void Function() switchLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.location_pin),
      color: Theme.of(context).colorScheme.onPrimary,
      tooltip: 'your location',
      onPressed: () async {
        switchLoading();
        fetchWeather();
      },
    );
  }
}
