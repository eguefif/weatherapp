import 'package:module03/models/weather_data.dart';

import 'package:flutter/material.dart';

class TitleBody extends StatelessWidget {
  const TitleBody({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    print(data.location["state"]);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${data.location["city"]}",
            style: Theme.of(context).textTheme.titleMedium),
        Text(
            "${data.location["state"] != "None" ? "${data.location["state"]}," : ""} ${data.location["country"] != "None" ? data.location["country"] : ""}",
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class TitleBodyRow extends StatelessWidget {
  const TitleBodyRow({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    print(data.location["state"]);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${data.location["city"]}",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 25),
        Text(
            "${data.location["state"]}${data.location["state"] != "None" ? "," : ""} ${data.location["country"]}",
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
