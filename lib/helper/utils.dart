import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';

class MapString {
  static Widget mapInputToWeather(String input, BuildContext context) {
    String text2;
    switch (input) {
      case 'Tornado':
        text2 = 'Tornado';
        break;
      case 'Thunderstorm':
        text2 = 'Thunderstorm';
        break;
      case 'Drizzle':
        text2 = 'Drizzly';
        break;
      case 'Rain':
        text2 = 'Raining';
        break;
      case 'Snow':
        text2 = 'Snowing';
        break;
      case 'Mist':
        text2 = 'Misty';
        break;
      case 'fog':
        text2 = 'Foggy';
        break;
      case 'Smoke':
        text2 = 'Smoky';
        break;
      case 'Squall':
        text2 = 'Squally';
        break;
      case 'Haze':
        text2 = 'Hazy';
        break;
      case 'Dust':
        text2 = 'Dusty';
        break;
      case 'Sand':
        text2 = 'Sandy';
        break;
      case 'Ash':
        text2 = 'Ashy';
        break;
      case 'Clear':
        text2 = "Sunny";
        break;
      case 'Clouds':
        text2 = "Cloudy";
        break;
      default:
        text2 = "No Info";
    }
    return Text(
      text2,
      style: TextStyle(fontSize: 15, color: Colors.white),
    );
  }

  static Icon mapStringToIcon(
      String input, BuildContext context, double iconSize) {
    IconData myIcon;
    switch (input) {
      case 'Thunderstorm':
        myIcon = WeatherIcons.thunderstorm;
        break;
      case 'Drizzle':
        myIcon = WeatherIcons.sprinkle;
        break;
      case 'Rain':
        myIcon = WeatherIcons.rain;
        break;
      case 'Snow':
        myIcon = WeatherIcons.snow;
        break;
      case 'Clear':
        myIcon = WeatherIcons.day_sunny;
        break;
      case 'Clouds':
        myIcon = WeatherIcons.cloudy;
        break;
      case 'Mist':
        myIcon = WeatherIcons.fog;
        break;
      case 'fog':
        myIcon = WeatherIcons.fog;
        break;
      case 'Smoke':
        myIcon = WeatherIcons.smoke;
        break;
      case 'Haze':
      case 'Dust':
      case 'Sand':
        myIcon = WeatherIcons.sandstorm;
        break;
      case 'Ash':
        myIcon = WeatherIcons.volcano;
        break;
      case 'Squall':
      case 'Tornado':
        myIcon = WeatherIcons.hurricane;
        break;
      default:
        myIcon = WeatherIcons.na;
    }
    return Icon(
      myIcon,
      size: iconSize,
      color: Colors.white,
    );
  }
}
