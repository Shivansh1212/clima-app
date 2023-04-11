import '../services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = 'f566d1706e3e56e8e50b9ebfa78ca50b';
const openWeatherMapurl = 'https://api.openweathermap.org/data/2.5/weather';
// const airPollutionurl = 'http://api.openweathermap.org/data/2.5/air_pollution';

class WeatherModel {
  Future getCityWeather(String cityname) async {
    var url = '$openWeatherMapurl?q=$cityname&appid=$apikey&units=metric';
    NetworkHelper networkhelper = NetworkHelper(url);
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getcurrentlocation();

    NetworkHelper networkhelper = NetworkHelper(
        '$openWeatherMapurl?lat=${location.lattitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  // Future getAirQuality() async {
  //   Location location = Location();
  //   var url =
  //       '$airPollutionurl?lat=${location.lattitude}&lon=${location.longitude}&appid=$apikey';
  //   NetworkHelper networkHelper = NetworkHelper(url);
  //   var pollutiondata = await networkHelper.getdata();
  //   return pollutiondata;
  // }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 30) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'It\'s pleasant weather';
    } else if (temp < 10) {
      return 'Be ready for cold if you are';
    } else {
      return 'Mild cool weather';
    }
  }

  // String getPollutionMessage(int ind) {
  //   if (ind == 1) {
  //     return 'Air quality is super good!';
  //   } else if (ind == 2) {
  //     return 'Air quality is good enough';
  //   } else if (ind == 3) {
  //     return 'Air quality is decent';
  //   } else if (ind == 4) {
  //     return 'Air quality is not good';
  //   } else {
  //     return 'Air quality is bad!';
  //   }
  // }
}
