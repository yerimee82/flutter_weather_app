import 'package:geolocator/geolocator.dart';

class MyLocation{

  late double latitude2;
  late double longitude2;

  Future<void> getMyCurrentLocation() async{
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator. //geolocator에게 값을 전달 받을 때 까지 기다렸다가 position 변수에 넣어라
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;

      print(latitude2);
      print(longitude2);

    }catch(e){
      print('There was a problem with the internet connection.');
    }
  }


}