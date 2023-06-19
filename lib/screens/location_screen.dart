import 'package:flutter/material.dart';
import 'package:weatherpal/screens/location_weather.dart';
import 'package:weatherpal/utilities/constants.dart';
import 'package:weatherpal/services/weather.dart';
import 'city_screen.dart';


//This class updates UI using location from loadingScreen or user interaction

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather, this.cities});

  final locationWeather;
  final cities;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  //I made them nullable
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  var weatherInfo;
  var cities;
  String? weatherDescription;

  @override
  void initState() {
    super.initState();

    //Get the location that was passed in from the loadingScreen
    updateUI(widget.locationWeather);

    weatherInfo = widget.locationWeather;
    cities = widget.cities;
    print("hello");
  }

  //Check if locationWeather is null, update UI components accordingly
  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      //WeatherData is in Json Format
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature!);
      cityName = weatherData['name'];

      weatherDescription = weatherData['weather'][0]['description'];

      print( weatherDescription);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: const AssetImage('images/location_background.jpg'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  //Get weather based on device location and update UI
                  TextButton(
                    onPressed: () async {

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return  MyLocationScreen(locationWeather: weatherInfo, cities: cities);
                        },
                      ),);

                      // var weatherData = await weather.getLocationWeather();
                      // updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),

                  //Get weather based on city input and update UI
                  TextButton(
                    onPressed: () async {

                      // Navigate to city screen where user enters cityName and pops

                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CityScreen();
                          },
                        ),
                      );

                      //City screen pops and sends cityName as typeName
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
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
                  children: <Widget>[
                    Text(
                      '$temperature°',
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
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
