import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

final Map<int, String> codeMap = {
  0: "Clear sky",
  1: "Mainly clear",
  2: "Partly couldy",
  3: "Overcast",
  45: "fog",
  48: "Depositing rime fog",
  51: "Light drizzle",
  52: "Moderate drizzle",
  53: "Dense drizzle",
  56: "Light freezing drizzle",
  57: "Dense freezing drizzle",
  61: "Slight rain",
  63: "Moderate rain",
  65: "Heavy rain",
  66: "Light freezing rain",
  67: "Heavy freezing rain",
  71: "Slight snow fall",
  73: "Moderate snow fall",
  75: "Heavy snow fall",
  77: "Snow grains",
  80: "Slight rain showers",
  81: "Moderate rain showers",
  82: "Violent rain showers",
  85: "Slight snow showers",
  86: "Heavy snow showers",
  95: "Thunderstorm",
  96: "Slight thunderstom with hail",
  99: "Heavy thunderstom with hail",
};

class WeatherCode {
  WeatherCode({required this.code}) : _description = codeMap[code];
  final String? _description;
  final int code;

  String? get description {
    return _description;
  }

  Icon getIcon(double size) {
    switch (code) {
      case 0:
      case 1:
        return  Icon(
            size: size,
            WeatherIcons.day_sunny);
      case 2:
        return  Icon(
            size: size,
            WeatherIcons.cloud);
      case 3:
        return  Icon(
            size: size,
            WeatherIcons.day_sunny_overcast);
      case 45:
      case 48:
        return  Icon(
            size: size,
            WeatherIcons.fog);
      case 51:
      case 52:
      case 53:
      case 56:
      case 57:
        return  Icon(
            size: size,
            WeatherIcons.sprinkle);
      case 61:
      case 63:
      case 65:
        return  Icon(
            size: size,
            WeatherIcons.rain);
      case 66:
      case 67:
        return  Icon(
            size: size,
            WeatherIcons.sleet);
      case 71:
      case 73:
      case 75:
      case 76:
      case 85:
      case 87:
      case 77:
        return  Icon(
            size: size,
            WeatherIcons.snow);
      case 80:
      case 81:
      case 82:
        return  Icon(
            size: size,
            WeatherIcons.showers);
      case 96:
        return  Icon(
            size: size,
            WeatherIcons.thunderstorm);
      case 99:
        return  Icon(
            size: size,
            WeatherIcons.thunderstorm);
      case 95:
        return  Icon(
            size: size,
            WeatherIcons.thunderstorm);
    }

    return  Icon(size: size, Icons.sunny);
  }
}
