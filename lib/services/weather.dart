import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey='3d2b8a80b33fd342dd135fa912554561';

class WeatherModel {


  Future<dynamic> getLocationWeather()async{
    Location location= Location();
    await location.getLocation();

    Network network= Network(url: 'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var decodedData = await network.getData();

    return decodedData;
  }

  Future<dynamic> getCityWeather(var cityName)async{
    print(cityName);
    Network network= Network(url:'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric');
    var decodedData= await network.getData();

    return decodedData;
  }



  String getWeatherIcon(int condition) {
    if(condition==null){
      return 'Error';
    } else if (condition < 300) {
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
