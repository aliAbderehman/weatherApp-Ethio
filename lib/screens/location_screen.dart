import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/utilities/constants.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  var locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temperature;
  int? condition;
  String? cityName;
  String? mainCon;
  String? weatherIcon;
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    // print(widget.locationWeather);
    updateWeather(widget.locationWeather);
  }

  void updateWeather(dynamic weatherData) {
    setState(() {
      WeatherModel weatherModel = WeatherModel();
      temperature = weatherData['main']['temp'] - 273.15;
      condition = weatherData['weather'][0]['id'];
      mainCon = weatherData['weather'][0]['main'];
      cityName = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition!);
      weatherMessage = weatherModel.getMessage(temperature!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(155, 49, 58, 42),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.near_me,
                                size: 35.0,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.location_city,
                                size: 35.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: [
                          Text(
                            '${(temperature?.round()).toString()}°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon!,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        mainCon!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        cityName!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontFamily: 'Spartan MB',
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        weatherMessage!,
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
