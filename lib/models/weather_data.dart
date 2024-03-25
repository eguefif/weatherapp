import 'package:module03/models/weather_code.dart';

class WeatherData {
  const WeatherData(
      {required this.location,
      required this.currentConditions,
      required this.today,
      required this.week,
      required this.error});

  final Map<String, String> location;
  final Map<String, dynamic> currentConditions;
  final Map<String, dynamic> today;
  final Map<String, dynamic> week;
  final Map<String, dynamic> error;

  factory WeatherData.fromJson(Map<String, dynamic> geoCoding,
      Map<String, dynamic> todayData, Map<String, dynamic> dailyData) {
    final location = getLocationData(geoCoding);
    final current = getCurrentData(todayData);
    final today = getTodayData(todayData);
    final week = getDailyData(dailyData);
    final Map<String, dynamic> error = {"error": false, "msg": ""};
    return WeatherData(
        location: location,
        currentConditions: current,
        today: today,
        week: week,
        error: error);
  }

  factory WeatherData.fromError(String errorMsg) {
    final location = {"city": "", "state": "", "country": ""};
    final currentConditions = {"temp": null, "description": "", "speed": null};
    final today = {
      "hours": [],
      "temperature": [],
      "description": [],
      "speed": []
    };
    final week = {"date": [], "maxs": [], "mins": [], "description": []};
    final error = {"error": true, "msg": errorMsg};
    return WeatherData(
        location: location,
        currentConditions: currentConditions,
        today: today,
        week: week,
        error: error);
  }

  factory WeatherData.fromNothing() {
    final location = {"city": "", "state": "", "country": ""};
    final currentConditions = {"temp": null, "description": "", "speed": null};
    final today = {
      "hours": [],
      "temperature": [],
      "description": [],
      "speed": []
    };
    final week = {"date": [], "maxs": [], "mins": [], "description": []};
    final error = {"error": false, "msg": ""};
    return WeatherData(
        location: location,
        currentConditions: currentConditions,
        today: today,
        week: week,
        error: error);
  }
}

Map<String, String> getLocationData(Map<String, dynamic> geoCoding) {
  Map<String, String> retval = {};
  retval["city"] = geoCoding["name"];
  retval["state"] = geoCoding.keys.contains("state") ? geoCoding["state"] : "None";
  retval["country"] = geoCoding.keys.contains("country") ? geoCoding["country"] : "None";
  return retval;
}

Map<String, dynamic> getDailyData(Map<String, dynamic> data) {
  Map<String, dynamic> retval = {};
  retval["date"] = [];
  retval["maxs"] = [];
  retval["mins"] = [];
  retval["description"] = [];

  List times = data["daily"]["time"];
  List maxs = data["daily"]["temperature_2m_max"];
  List mins = data["daily"]["temperature_2m_min"];
  List descriptions = data["daily"]["weather_code"];

  for (int i = 0; i < 7; i++) {
    retval["date"].add(
        "${DateTime.parse(times[i]).day}/${DateTime.parse(times[i]).month}");
    retval["maxs"].add(maxs[i] as double);
    retval["mins"].add(mins[i] as double);
    retval["description"].add(WeatherCode(code: descriptions[i]));
  }
  return retval;
}

Map<String, dynamic> getTodayData(Map<String, dynamic> data) {
  Map<String, dynamic> retval = {};
  retval["hours"] = [];
  retval["temperature"] = [];
  retval["description"] = [];
  retval["speed"] = [];

  List times = data["hourly"]["time"];
  List temp = data["hourly"]["temperature_2m"];
  List speed = data["hourly"]["wind_speed_10m"];
  List descriptions = data["hourly"]["weather_code"];
  int startIdx = 0; //getStartIdx(times);

  for (int i = startIdx; i < startIdx + 24; i++) {
    retval["hours"].add(DateTime.parse(times[i]).hour);
    retval["temperature"].add(temp[i]);
    retval["description"].add(WeatherCode(code: descriptions[i]));
    retval["speed"].add(speed[i]);
  }
  return retval;
}

int getStartIdx(List times) {
  final now = DateTime.now();

  for (int i = 0; i < times.length; i++) {
    var time = DateTime.parse(times[i]);
    if (now.hour < time.hour) {
      if (i == 0) {
        return 0;
      }
      return i - 1;
    }
  }
  return 0;
}

Map<String, dynamic> getCurrentData(Map<String, dynamic> data) {
  Map<String, dynamic> retval = {};

  int currentIdx = getStartIdx(data["hourly"]["time"]);
  retval["temp"] = data["hourly"]["temperature_2m"][currentIdx];
  retval["description"] =
      WeatherCode(code: data["hourly"]["weather_code"][currentIdx]);
  retval["speed"] = data["hourly"]["wind_speed_10m"][currentIdx];
  return retval;
}

bool isNoData(WeatherData data) {
  return !data.error["error"] &&
      (data.location["city"] == null || data.location["city"] == "");
}
