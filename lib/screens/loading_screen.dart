import 'dart:math';

import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherpal/services/weather.dart';

import 'location_weather.dart';

//This class gets location and sends it to the location screen
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();

  }

  //This method gets the weather for device's location through the weatherModel that has two options for returning weather
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    List<dynamic> cities =  await getCitiesData();

    print('hey $cities');

    //send the weatherData to the LocationScreen
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyLocationScreen(
        locationWeather: weatherData,
        cities: cities,
      );
    }));
  }


  // Will possibly move this to the location screen, to run a check to see if users current location is in the list

  Future<List<dynamic>> getCitiesData() async{

    List<String> allCities = ['Portharcourt', 'Owerri', 'Kano', 'Kaduna', 'Jos', 'Ogun', "Benin"];

    List<String> randomCities = getRandomCities(allCities, 3);

    print("$randomCities");

    String cityName1 = randomCities[0];
    String cityName2 = randomCities[1];
    String cityName3 = randomCities[2];

    print(cityName1);
    print(cityName2);
    print(cityName3);


    List<dynamic> weatherList = await WeatherModel().getCitiesWeather(cityName1, cityName2, cityName3);

    return weatherList;

  }

  List<String> getRandomCities(List<String> cities, int count) {
    // Shuffle the items list
    cities.shuffle(Random());

    // Return the first 'count' items from the shuffled list
    return cities.sublist(0, count);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: const <Widget>[

        Image(image: AssetImage('images/Weather.png')),
        Text(
          "WeatherPal",
          style: TextStyle(fontSize: 40,
          color: Colors.white),
        ),
        Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ]),
    );
  }
}

