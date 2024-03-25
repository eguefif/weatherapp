import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';


IconData getWindIcon(double speed) {
  if (speed == 0) return WeatherIcons.wind_beaufort_0;
  if (speed > 0 && speed <= 5) return WeatherIcons.wind_beaufort_1;
  if (speed > 6 && speed <= 11) return WeatherIcons.wind_beaufort_2;
  if (speed > 12 && speed <= 19) return WeatherIcons.wind_beaufort_3;
  if (speed > 20 && speed <= 28) return WeatherIcons.wind_beaufort_4;
  if (speed > 29 && speed <= 38) return WeatherIcons.wind_beaufort_5;
  if (speed > 38 && speed <= 49) return WeatherIcons.wind_beaufort_6;
  if (speed > 50 && speed <= 61) return WeatherIcons.wind_beaufort_7;
  if (speed > 62 && speed <= 74) return WeatherIcons.wind_beaufort_8;
  if (speed > 75 && speed <= 88) return WeatherIcons.wind_beaufort_9;
  if (speed > 89 && speed <= 102) return WeatherIcons.wind_beaufort_10;
  if (speed > 103 && speed <= 117) return WeatherIcons.wind_beaufort_11;
  if (speed > 118) return WeatherIcons.wind_beaufort_12;
  return WeatherIcons.wind_beaufort_0;
}
