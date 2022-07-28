import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';

class FiveDayForecast extends StatelessWidget {
  final wData;
  final List<DailyWeather>? dWeather;

  FiveDayForecast({this.wData, this.dWeather});

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('EEE').format(weather.date);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  dayOfWeek,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: MapString.mapStringToIcon(
                    '${weather.condition}', context, 35),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${weather.dailyTempMin.toStringAsFixed(0)}° / ${weather.dailyTempMax.toStringAsFixed(0)} °'
                    .toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15, left: 20),
          child: Text(
            'Next 5 Days',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 231, 222, 222).withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(4, 8),
              ),
            ],
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${wData.weather.temp.toStringAsFixed(1)}°',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      MapString.mapInputToWeather(
                          '${wData.weather.currently}', context)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MapString.mapStringToIcon(
                        '${wData.weather.currently}', context, 45),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dWeather!
                      .map((item) => dailyWidget(item, context))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
