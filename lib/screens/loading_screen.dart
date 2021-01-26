import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocationData();

  }

  void getLocationData() async{
    WeatherModel weatherModel=WeatherModel();

    var decodedData= await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(weatherData: decodedData,);}));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: SpinKitWanderingCubes(color:Colors.white,size: 100)),
    );
  }
}
