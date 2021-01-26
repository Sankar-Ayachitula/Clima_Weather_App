import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';


class LocationScreen extends StatefulWidget {

  LocationScreen({this.weatherData});

  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {


  WeatherModel weatherModel= WeatherModel();

  int temperature;
  int  condition;
  String cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dynamic decodedData=widget.weatherData;
    updateUI(decodedData);

  }

  void updateUI(dynamic weatherData){
    setState(() {
      if(weatherData==null){
        temperature=0;
        condition= null;
        cityName= '';
        return;
      }
      temperature= weatherData['main']['temp'].toInt();
      condition= weatherData['weather'][0]['id'];
      cityName= weatherData['name'];
    });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()  {
                      setState(() async{
                        dynamic weatherData2= await weatherModel.getLocationWeather();
                        updateUI(weatherData2);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {
                      var typedName= await Navigator.push(context, MaterialPageRoute(builder: (context){return CityScreen();}));
                      print(typedName);

                      if(typedName!=null){
                        dynamic decodedData= await weatherModel.getCityWeather(typedName);
                        updateUI(decodedData);

                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModel.getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherModel.getMessage(temperature)+' in $cityName',
                  textAlign: TextAlign.right,
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



