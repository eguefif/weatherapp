import 'package:flutter/material.dart';
import 'package:module03/widget/top_bar.dart';
import 'package:module03/widget/helpers/gps_button.dart';
import 'package:module03/widget/screens/current_screen.dart';
import 'package:module03/widget/screens/today_screen.dart';
import 'package:module03/widget/screens/weekly_screen.dart';
import 'package:module03/models/weather_data.dart';
import 'package:module03/controllers/weather_fetcher.dart';
import 'package:module03/controllers/locator_controller.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() {
    return _WeatherApp();
  }
}

class _WeatherApp extends State<WeatherApp> {
  String key = "";
  WeatherData data = WeatherData.fromNothing();
  final double opacity = 0.7;

  @override
  void initState() {
    getLocation().then((position) {
      WeatherFetcher fetcher = WeatherFetcher(
          latitude: position.latitude, longitude: position.longitude);
      fetcher.fetchWeather().then((newData) {
        setState(() {
          data = newData;
        });
      });
    }).catchError((error) {
      setState(() {
        data.error["error"] = true;
        data.error["msg"] = error;
      });
    });
    super.initState();
  }

  void changeLocation(List<double> newLocation) {
    WeatherFetcher fetcher =
        WeatherFetcher(latitude: newLocation[0], longitude: newLocation[1]);
    fetcher.fetchWeather().then((tmpData) {
      setState(() {
        data = tmpData;
      });
    });
  }

  void switchToLoadingScreen(){
    setState(() {
      data.error["error"] = false;
      data.location["city"] = "";
    });

  }

  void fetchWeather() async {

    getLocation().then((position) {
      WeatherFetcher fetcher = WeatherFetcher(
          latitude: position.latitude, longitude: position.longitude);
      fetcher.fetchWeather().then((tmpData) {
        setState(() {
          data = tmpData;
        });
      });
    }).catchError((error) {
      setState(() {
        data.error["error"] = true;
        data.error["msg"] = error;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: TopBar(changeLocation: changeLocation, switchLoading: switchToLoadingScreen),
          toolbarHeight: 85,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: <Widget>[
            GpsButton(fetchWeather: fetchWeather, switchLoading: switchToLoadingScreen),
          ],
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/wallpaper.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(opacity),
                BlendMode.darken,
              ),
            ),
          ),
          child: TabBarView(
            children: [
              CurrentScreen(data: data),
              TodayScreen(data: data),
              WeeklyScreen(data: data),
            ],
          ),
        ),
        bottomNavigationBar: const TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.now_widgets), child: Text("Currently")),
            Tab(icon: Icon(Icons.calendar_today), child: Text("Today")),
            Tab(icon: Icon(Icons.calendar_view_week), child: Text("Weekly")),
          ],
        ),
      ),
    );
  }
}