import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';

import '../models/weather.dart';
import '../models/dailyWeather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = '8b86dcf703483d4a0ad63a6a3ef0156c';
  Weather weather = Weather();
  DailyWeather currentWeather = DailyWeather();
  List<DailyWeather> fiveDayWeather = [];

  late bool loading;
  bool isRequestError = false;
  bool isLocationError = false;

  getWeatherData() async {
    loading = true;
    isRequestError = false;
    isLocationError = false;
    await Location().requestService().then((value) async {
      if (value) {
        final locData = await Location().getLocation();
        var latitude = locData.latitude;
        var longitude = locData.longitude;
        Uri url = Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
        Uri dailyUrl = Uri.parse(
            'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');
        try {
          final response = await http.get(url);
          final extractedData =
              json.decode(response.body) as Map<String, dynamic>;
          weather = Weather.fromJson(extractedData);
        } catch (error) {
          loading = false;
          this.isRequestError = true;
          notifyListeners();
        }
        try {
          final response = await http.get(dailyUrl);
          final dailyData = json.decode(response.body) as Map<String, dynamic>;
          currentWeather = DailyWeather.fromJson(dailyData);

          var tempFiveDay;
          List items = dailyData['daily'];

          tempFiveDay = items
              .map((item) => DailyWeather.fromDailyJson(item))
              .toList()
              .skip(1)
              .take(5)
              .toList();
          fiveDayWeather = tempFiveDay;
          loading = false;
          notifyListeners();
        } catch (error) {
          throw error;
        }
      } else {
        loading = false;
        isLocationError = true;
        notifyListeners();
      }
    });
  }

  searchWeatherData({required String location}) async {
    loading = true;
    isRequestError = false;
    isLocationError = false;
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
    var latitude = weather.lat;
    var longitude = weather.long;
    print(latitude);
    print(longitude);
    Uri dailyUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&units=metric&exclude=minutely,current&appid=$apiKey');
    try {
      final response = await http.get(dailyUrl);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      print(dailyUrl);
      currentWeather = DailyWeather.fromJson(dailyData);

      var tempFiveDay;
      List items = dailyData['daily'];

      tempFiveDay = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(5)
          .toList();

      fiveDayWeather = tempFiveDay;
      loading = false;
      notifyListeners();
    } catch (error) {
      loading = false;
      this.isRequestError = true;
      notifyListeners();
      throw error;
    }
  }
}
