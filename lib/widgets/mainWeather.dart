import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({this.wData});

  final TextStyle _style1 =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white);
  final TextStyle _style2 = const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontSize: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 5),
                child: MapString.mapStringToIcon(
                  '${wData.weather.currently}',
                  context,
                  75,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      Text('${wData.weather.cityName}',
                          style: const TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat.yMMMEd().add_jm().format(DateTime.now()),
                    style: _style2,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${wData.weather.temp.toStringAsFixed(0)}°C',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${wData.weather.tempMin.toStringAsFixed(0)}°/ ${wData.weather.tempMax.toStringAsFixed(0)}° ',
                    style: _style1.copyWith(fontSize: 19),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
                style: _style1.copyWith(fontSize: 19),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
