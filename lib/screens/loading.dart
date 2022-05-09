import 'package:flutter/material.dart';
import 'package:weather/data/my_location.dart';
import 'package:http/http.dart' as http;
import 'package:weather/screens/weather_screen.dart';
import 'dart:convert';
import '../data/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = 'fa9b87ca56374bd5d8dd2c248706e4e0';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    //딱 한번만 호출되는 메서드
    super.initState();
    getLocation(); //매번 실행 불가
    //fetchData();
  }

  Future<void> getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  // void fetchData() async{
  //
  //   http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
  //   if(response.statusCode == 200) {
  //     String jsonData = response.body;
  //     var parsingData = jsonDecode(jsonData);
  //     var myJson = parsingData['weather'][0]['description'];
  //     //print(myJson);
  //     var windSpeed = parsingData(jsonData)['wind']['speed'];
  //     var id = parsingData['id'];
  //
  //     print(windSpeed);
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
