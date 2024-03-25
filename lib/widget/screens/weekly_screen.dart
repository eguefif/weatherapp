import 'package:flutter/material.dart';
import 'package:module03/models/weather_data.dart';
import 'package:module03/widget/screens/loading_screen.dart';
import 'package:module03/widget/screens/error_screen.dart';
import 'package:module03/widget/helpers/title.dart';
import 'package:module03/widget/charts/weekly_chart.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({super.key, required this.data}) : title = "Weekly";

  final WeatherData data;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (isNoData(data)) {
      return const LoadingScreen();
    }
    if (data.error["error"]) {
      return ErrorBody(data: data);
    }
    if (MediaQuery.of(context).size.height > 600) {
      return WeeklyScreenResponsiveVertical(data: data);
    }
    return WeeklyScreenResponsiveHorizontal(data: data);
  }
}

class WeeklyScreenResponsiveVertical extends StatelessWidget {
  const WeeklyScreenResponsiveVertical({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleBody(data: data),
          const SizedBox(height: 55),
          Text("Weekly temperatures",
              style: Theme.of(context).textTheme.titleMedium),
          WeeklyChart(
            maxData: buildSeriesWeek(data.week["maxs"]),
            minData: buildSeriesWeek(data.week["mins"]),
            xAxisTitle: data.week["date"],
          ),
         const SizedBox(height: 38),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: data.week["date"].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) =>
                  WeeklyListWeatherTile(index: index, data: data),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyScreenResponsiveHorizontal extends StatelessWidget {
  const WeeklyScreenResponsiveHorizontal({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WeeklyChart(
            maxData: buildSeriesWeek(data.week["maxs"]),
            minData: buildSeriesWeek(data.week["mins"]),
            xAxisTitle: data.week["date"],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              TitleBodyRow(data: data),
              SizedBox(
                height: 150,
                width: 450,
                child: ListView.builder(
                  itemCount: data.week["date"].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) =>
                      WeeklyListWeatherTile(index: index, data: data),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeeklyListWeatherTile extends StatelessWidget {
  const WeeklyListWeatherTile(
      {super.key, required this.index, required this.data});

  final WeatherData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text("${data.week["date"][index]}",
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            data.week["description"][index].getIcon(45.0),
            const SizedBox(height: 15),
            Text(
              "${data.week["maxs"][index]}\u2103",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            Text(
              "${data.week["mins"][index]}\u2103",
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(width: 25),
      ],
    );
  }
}
