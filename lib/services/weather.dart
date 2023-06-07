import 'package:weatherpal/services/location.dart';
import 'package:weatherpal/services/networking.dart';

//This class presents users two ways to retrieve weatherData, using their location and using any city name.

const apiKey = 'fcaa3aee582b1fb1dae2753c2ee4ce40';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {

  // get location based on city name inputted by the users
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //This method gets location, sends the location to the openWeather API and gets its weatherData
  Future<dynamic> getLocationWeather() async {

    //use an instance of the location object to call its getLocation method
      Location location = Location();
      await location.getCurrentLocation();

      //send request to the API using the location
      String weatherUrl = '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
      NetworkHelper networkHelper = NetworkHelper(weatherUrl);
      print('Your lon is: ${location.longitude}');

      var weatherData = await networkHelper.getData();
      print('Weather data: $weatherData');

      return weatherData;

  }

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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
