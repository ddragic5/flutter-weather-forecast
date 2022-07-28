import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  var dailyTemp;
  var condition;
  var date;
  var precip;
  var uvi;
  var dailyTempMin;
  var dailyTempMax;
  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
    this.dailyTempMax,
    this.dailyTempMin,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    final precipData = json['daily'][0]['pop'];
    final calcPrecip = precipData * 100;
    final precipitation = calcPrecip.toStringAsFixed(0);
    return DailyWeather(
      precip: precipitation,
      uvi: json['daily'][0]['uvi'],
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      dailyTempMax: json['temp']['max'],
      dailyTempMin: json['temp']['min'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }
}
