import 'package:flutter/material.dart';
import 'package:weatherpal/ForecastScreen.dart';
import 'package:weatherpal/color_constants.dart';
import 'package:weatherpal/utilities/bottom_button.dart';
import 'package:weatherpal/utilities/constants.dart';
import 'package:weatherpal/services/weather.dart';
import 'city_screen.dart';

//This class updates UI using location from loadingScreen or user interaction

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key, this.locationWeather, this.cities});

  final dynamic locationWeather;
  final cities;

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  WeatherModel weather = WeatherModel();

  //I made them nullable
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  String? weatherDescription;
  var weatherInfo;

  int? cardTemp1;
  String? cardIcon1;
  String? cardName1;

  int? cardTemp2;
  String? cardIcon2;
  String? cardName2;

  int? cardTemp3;
  String? cardIcon3;
  String? cardName3;

  @override
  void initState() {
    super.initState();

    //Get the location that was passed in from the loadingScreen
    updateUI(widget.locationWeather);
    updateCardUI(widget.cities);

    weatherInfo = widget.locationWeather;
    print("hello y");
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
      weatherDescription = weatherData['weather'][0]['description'];

      print(weatherDescription);

      //change to get weather image
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature!);
      cityName = weatherData['name'];
    });
  }

  void updateCardUI(dynamic cities) {

      if (cities == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      dynamic firstCity = cities[0];
      dynamic secondCity = cities[1];
      dynamic thirdCity = cities[2];

      //First city
      double temp1 = firstCity['main']['temp'];
      cardTemp1 = temp1.toInt();
      var condition = firstCity['weather'][0]['id'];
      cardIcon1 = weather.getWeatherIcon(condition);
      cardName1 = firstCity['name'];

      // Second city
      double temp2 = secondCity['main']['temp'];
      cardTemp2 = temp2.toInt();
      var condition2 = secondCity['weather'][0]['id'];
      cardIcon2 = weather.getWeatherIcon(condition2);
      cardName2 = secondCity['name'];

      // third city
      double temp3 = thirdCity['main']['temp'];
      cardTemp3 = temp3.toInt();
      var condition3 = thirdCity['weather'][0]['id'];
      cardIcon3 = weather.getWeatherIcon(condition3);
      cardName3 = thirdCity['name'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.orangeWeb,
                image: DecorationImage(
                  image: const AssetImage('images/background_sunny.png'),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.orange.withOpacity(0.4), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$weatherDescription'.toUpperCase(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          weatherIcon!,
                          style: kConditionTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(

                      "$weatherMessage in $cityName!",
                      style: kMessageTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

           Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 30, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Other cities",
                style: kTextStyle),
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
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Scrollbar(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: AppColors.CYAN,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/sun.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$cardTemp1°C',
                                style: kTextStyle,
                              ),

                              const SizedBox(height: 10),
                               Text(
                                '$cardName1',
                                style: kTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: AppColors.CYAN,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/sun.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$cardTemp2°C',
                                style: kTextStyle,
                              ),
                              const SizedBox(height: 10),
                               Text(
                                   '$cardName2',
                                   style: kTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: AppColors.CYAN,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/sun.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$cardTemp3°C',
                                style: kTextStyle,
                              ),
                              const SizedBox(height: 10),
                               Text(
                                 '$cardName3',
                                 style: kTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: BottomButton(
                onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ForecastScreen();
              }));
            }, buttonTitle: "Get Forecasts"),
          )
        ],
      ),
    ));
  }
}
