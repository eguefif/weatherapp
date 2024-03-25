import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quiver/iterables.dart';

class TodayChart extends StatelessWidget {
  const TodayChart({super.key, required this.data});
  final List<Point> data;

  @override
  Widget build(BuildContext context) {
    Widget leftChartTitle(double value, TitleMeta meta) {
      Text retval;
      retval =
          Text("$value \u2103", style: Theme.of(context).textTheme.bodySmall);
      return retval;
    }

    Widget botChartTitle(double value, TitleMeta meta) {
      Text retval;
      retval =
          Text("${value.toInt()}:00", style: Theme.of(context).textTheme.bodySmall);
      return retval;
    }

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChart(
          LineChartData(
            minY: getMinPointY(data) - 1,
            maxY: getMaxPointY(data),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftChartTitle,
                    reservedSize: 42,
                    interval: 2),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: botChartTitle,
                    reservedSize: 42,
                    interval: 5),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: data.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Point {
  const Point({required this.x, required this.y});

  final double x;
  final double y;
}

List<Point> buildSeries(List<dynamic> data1, List<dynamic> data2) {
  final List<Point> retval = [];

  for (var pair in zip([data1, data2])) {
    retval.add(Point(x: pair[0].toDouble(), y: pair[1].toDouble()));
  }
  return retval;
}

double getMinPointY(List<Point> data) {
  double min = 30;

  for (Point datum in data) {
    if (datum.y < min)  min = datum.y;
  }
  return min;
}

double getMaxPointY(List<Point> data) {
  double max = -50;

  for (Point datum in data) {
    if (datum.y > max)  max = datum.y;
  }
  return max;
}
