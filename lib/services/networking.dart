import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Network{

  Network({@required this.url});

  final String url;

  Future<dynamic> getData() async{
    Response response= await get(url);
    print(response);
    if(response.statusCode==200){
      String data= response.body;
      print(data);
      var decodedData= jsonDecode(data);
      return decodedData;
    }else{
      print(response.statusCode);
    }
  }

}