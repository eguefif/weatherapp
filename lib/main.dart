import 'package:flutter/material.dart';
import 'package:module03/widget/weather_app.dart';
import 'package:module03/widget/screens/search_page.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 221, 92, 18),
    brightness: Brightness.dark);

void main() {
  runApp(
    MaterialApp(
      theme: getTheme(),
      onGenerateRoute: (settings) {
        if (settings.name == '/searchPage') {
          List arg = settings.arguments as List;
          final void Function(List<double>) changeLocation = arg[0];
          final void Function() switchLoading = arg[1];

          return MaterialPageRoute(
            builder: (context) => SearchPage(
              changeLocation: changeLocation,
              switchLoading: switchLoading,
            ),
          );
        }
        
        return MaterialPageRoute(builder: (context) => const WeatherApp());
      },
    ),
  );
}

ThemeData getTheme(){
  return ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,
        textTheme: TextTheme(
          bodySmall: TextStyle(color: kColorScheme.onBackground, fontSize: 10),
          bodyMedium: TextStyle(color: kColorScheme.tertiary, fontSize: 20),
          bodyLarge: TextStyle(color: kColorScheme.tertiary, fontSize: 25),
          titleMedium: TextStyle(
            color: kColorScheme.primary,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: kColorScheme.primary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}