import 'package:weather_app/services/location.dart';
import '../services/networking.dart';
import 'dart:convert';

const weatherApiKey = '8cbd8d013b19a445f70faf5de9fbd37f';

class WeatherModel {
  WeatherModel() {
    getLocationWeather();
  }
  dynamic decData;
  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getPosition();

    NetworkHelper currentWeather = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$weatherApiKey');
    currentWeather.getData();

    var weatherData = await currentWeather.getData();
    var decodedData = await jsonDecode(weatherData);
    return await decodedData;
  }

  // Object getDecodedData() {
  //   return decodedData!;
  // }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
