import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../providers/weatherProvider.dart';
import '../widgets/fade_in.dart';
import '../widgets/fiveDayForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/searchBar.dart';
import '../widgets/weatherDetail.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: myContext.primaryColor,
              ),
            )
          : weatherData.loading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                  ),
                )
              : weatherData.isLocationError
                  ? LocationError()
                  : Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                            Colors.blue,
                            Colors.lightBlue,
                            Colors.lightBlueAccent,
                            Colors.white
                          ])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SearchBar(),
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: mediaQuery.size.width,
                                  child: ListView(
                                    children: [
                                      FadeIn(
                                          delay: 0.33,
                                          child:
                                              MainWeather(wData: weatherData)),
                                      Container(
                                        height: mediaQuery.size.height,
                                        width: mediaQuery.size.width,
                                        child: ListView(
                                          children: [
                                            FadeIn(
                                              delay: 0.33,
                                              child: FiveDayForecast(
                                                wData: weatherData,
                                                dWeather:
                                                    weatherData.fiveDayWeather,
                                              ),
                                            ),
                                            FadeIn(
                                                delay: 0.66,
                                                child: WeatherDetail(
                                                    wData: weatherData)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
