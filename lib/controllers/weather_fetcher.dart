import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:module03/models/weather_data.dart';
import 'package:module03/controllers/key.dart';


class WeatherFetcher {
  WeatherFetcher({required this.latitude, required this.longitude})
      : geoCoding =
            "https://api.openweathermap.org/geo/1.0/reverse?lat=$latitude&lon=$longitude&appid=$key",
        todayApi =
            "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m,wind_speed_10m,weather_code",
        dailyApi =
            "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,weather_code";

  final double latitude;
  final double longitude;

  final String geoCoding;
  final String todayApi;
  final String dailyApi;

  Future<WeatherData> fetchWeather() async {
    final geoResponse = await http.get(Uri.parse(geoCoding));
    final todayResponse = await http.get(Uri.parse(todayApi));
    final dailyResponse = await http.get(Uri.parse(dailyApi));

    if (geoResponse.statusCode == 200 &&
        todayResponse.statusCode == 200 &&
        dailyResponse.statusCode == 200) {
      var geo = jsonDecode(geoResponse.body) as List<dynamic>;
      var today = jsonDecode(todayResponse.body) as Map<String, dynamic>;
      var daily = jsonDecode(dailyResponse.body) as Map<String, dynamic>;
      return WeatherData.fromJson(geo[0], today, daily);
    }
    return WeatherData.fromError("Cannot fetch data.");
  }
}