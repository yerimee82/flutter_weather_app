import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Model{
  Widget getWeatherIcon(int condition){
    if(condition < 300){ //천둥번개, 비
      return SvgPicture.asset('svg/climacon-lightning.svg',
      color: Colors.black87,
      );
    }else if(condition < 600) { //천둥번개, 비
      return SvgPicture.asset('svg/climacon-cloud_snow_alt.svg',
        color: Colors.black87,
      );
    }else if(condition == 800){ //천둥번개, 비
      return SvgPicture.asset('svg/climacon-sun.svg',
        color: Colors.black87,
      );
    }else if(condition <= 804){ //천둥번개, 비
      return SvgPicture.asset('svg/climacon-cloud_sun.svg',
        color: Colors.black87,
      );
    }
    return SvgPicture.asset('svg.climacon-cloud-moon.svg');
  }

  Widget getAirIcon(int index) {
    if (index == 1) {
      return Image.asset(
        'image/good.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        'image/fair.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 3) {
      return Image.asset(
        'image/moderate.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 4) {
      return Image.asset(
        'image/poor.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 5) {
      return Image.asset(
        'image/bad.png',
        width: 37.0,
        height: 35.0,
      );
    }

    return Image.asset('image/good.png', width: 37.0, height: 35.0);
  }

  Widget getAirCondition(int index){
    if (index == 1) {
      return const Text(
        '"매우 좋음"',
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold
        ),
      );
    } else if (index == 2) {
      return const Text(
        '"좋음"',
        style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold
        ),
      );
    } else if (index == 3) {
      return const Text(
        '"보통"',
        style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold
        ),
      );
    } else if (index == 4) {
      return const Text(
        '"나쁨"',
        style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold
        ),
      );
    } else {
      const Text(
        '"매우 나쁨"',
        style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold
        ),
      );
    }
    return Text('"좋음"');
  }
}