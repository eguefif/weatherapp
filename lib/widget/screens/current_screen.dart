import 'package:flutter/material.dart';
import 'package:module03/widget/helpers/wind_icon.dart';
import 'package:module03/widget/helpers/title.dart';
import 'package:module03/models/weather_data.dart';
import 'package:module03/widget/screens/loading_screen.dart';
import 'package:module03/widget/screens/error_screen.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    if (isNoData(data)) {
      return const LoadingScreen();
    }
    if (data.error["error"]) {
      return ErrorBody(data: data);
    }
    if (MediaQuery.of(context).size.height > 600) {
      return CurrentScreenResponsiveVerticalLayout(data: data);
    } else {
      return CurrentScreenResponsiveHorizontalLayout(data: data);
    }
  }
}

class CurrentScreenResponsiveVerticalLayout extends StatelessWidget {
  const CurrentScreenResponsiveVerticalLayout({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBody(data: data),
          Text("${data.currentConditions["temp"]} \u2103",
              style: Theme.of(context).textTheme.titleLarge),
          Column(
            children: [
              Text("${data.currentConditions["description"].description}",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              data.currentConditions["description"].getIcon(75.0),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(size: 55, getWindIcon(data.currentConditions["speed"])),
              const SizedBox(width: 15),
              Text("${data.currentConditions["speed"]} km/h",
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class CurrentScreenResponsiveHorizontalLayout extends StatelessWidget {
  const CurrentScreenResponsiveHorizontalLayout(
      {super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBody(data: data),
          Text("${data.currentConditions["temp"]} \u2103",
              style: Theme.of(context).textTheme.titleLarge),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${data.currentConditions["description"].description}",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              data.currentConditions["description"].getIcon(75.0),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(size: 55, getWindIcon(data.currentConditions["speed"])),
                const SizedBox(width: 15),
                Text("${data.currentConditions["speed"]} km/h",
                    style: Theme.of(context).textTheme.bodyMedium),
              ]),
        ],
      ),
    );
  }
}
