import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quiver/iterables.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key, required this.maxData, required this.minData, required this.xAxisTitle});

  final List<PointWeek> maxData;
  final List<PointWeek> minData;
  final List<dynamic> xAxisTitle;

  @override
  Widget build(BuildContext context){
    Widget leftChartTitle(double value, TitleMeta meta) {
      Text retval;
      retval =
          Text("$value \u2103", style: Theme.of(context).textTheme.bodySmall);
      return retval;
    }

    Widget botChartTitle(double value, TitleMeta meta) {
      Text retval;
      retval =
          Text(xAxisTitle[value.toInt()], style: Theme.of(context).textTheme.bodySmall);
      return retval;
    }
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LineChart(
          LineChartData(
            minY: getMinPointYWeek(maxData, minData) - 1,
            maxY: getMaxPointYWeek(maxData, minData) + 2,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftChartTitle,
                    reservedSize: 42,
                    interval: 3),
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
                color: Colors.red,
                spots: maxData.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
              ),
              LineChartBarData(
                color: Colors.blue,
                spots: minData.map((point) => FlSpot(point.x, point.y)).toList(),
                isCurved: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double getMinPointYWeek(List<PointWeek> maxs, List<PointWeek> mins) {
  double retval = 30;

  for (PointWeek datum in maxs) {
    if (datum.y < retval)  retval = datum.y;
  }
  for (PointWeek datum in mins) {
    if (datum.y < retval)  retval = datum.y;
  }
  return retval;
}

double getMaxPointYWeek(List<PointWeek> maxs, List<PointWeek> mins) {
  double retval = -50;

  for (PointWeek datum in maxs) {
    if (datum.y > retval)  retval = datum.y;
  }
  for (PointWeek datum in mins) {
    if (datum.y > retval)  retval = datum.y;
  }
  return retval;
}

class PointWeek {
  const PointWeek({required this.x, required this.y});

  final double x;
  final double y;
}

List<PointWeek> buildSeriesWeek(List<dynamic> data) {
  final List<PointWeek> retval = [];
  List<double> x = [];

  for (int i = 0; i < data.length; i++){
    x.add(i.toDouble());
  }

  for (var pair in zip([x, data])) {
    retval.add(PointWeek(x: pair[0] as double, y: pair[1] as double));
  }
  return retval;
}