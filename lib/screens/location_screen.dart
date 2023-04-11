// ignore_for_file:  use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final locationweather;
  // final locationpol;
  const LocationScreen({this.locationweather});
  // this.locationpol
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 1;
  String weatherIcon = '';
  String message = 'hello';
  String cityName = 'Bhopal';
  String polmessage = '';
  int index = 0;
  @override
  void initState() {
    updateUI(widget.locationweather);
    // updateUI2(widget.locationpol);
    super.initState();
  }

  void updateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        weatherIcon = 'ERROR!';
        message = 'Unable to get weather data';
        cityName = '';
      } else {
        double temp = weatherdata['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherdata['weather'][0]['id'];
        cityName = weatherdata['name'];
        weatherIcon = weather.getWeatherIcon(condition);
        message = weather.getMessage(temperature);
      }
    });
  }

  // void updateUI2(dynamic x) {
  //   setState(
  //     () {
  //       if (x == null) {
  //         polmessage = 'NO CITY';
  //       } else {
  //         var ind = x['list'][0]['main']['aqi'];
  //         polmessage = weather.getPollutionMessage(ind);
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima App'),
        backgroundColor: Colors.black38,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weather.getLocationWeather();
                      // var poldata = await weather.getAirQuality();
                      updateUI(weatherdata);
                      // updateUI2(poldata);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typename = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typename != null) {
                        var weatherdata =
                            await weather.getCityWeather(typename);
                        updateUI(weatherdata);
                        // var poldata = await weather.getAirQuality();
                        // poldata = await weather.getAirQuality();
                        // updateUI2(poldata);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°c',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15.0),
              //   child: Text(
              //     polmessage,
              //     style: TextStyle(
              //       fontSize: 50,
              //       fontFamily: 'Spartan MB',
              //     ),
              //   ),
              // ),
              Container(
                color: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    "$message in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
