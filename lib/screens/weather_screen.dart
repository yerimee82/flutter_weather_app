import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseAirPollution;
  final dynamic parseWeatherData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String cityName;
  late int temp;
  Widget icon = SvgPicture.asset('svg/climacon-cloud_moon.svg');
  late String des;
  late Widget airIcon;
  late Widget airState;
  late double dust1;
  late double dust2;
  var date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    temp = temp2.round();
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition);
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);

    // double temp2 = weatherData['main']['temp'];
    // temp = temp2.toInt(); //double 데이터를 int로 변경하여 저장(round() 함수 또한 사용 가능)



    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //앱바 영역 확대(투명도 설정 위해)
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          //아이콘 버튼을 왼쪽에 배치하는 leading 속성
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [
          //복수의 아이콘 버튼을 오른쪽에 배치하는 actions 속성
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset('image/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity //이미지 화면 상에 꽉차게
                ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded( //최대한의 공간 확보
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 150.0,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(Duration(minutes: 1),
                                    builder: (context) {
                                  print('${getSystemTime()}');
                                  return Text(
                                    '${getSystemTime()}',
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white60),
                                  );
                                }),
                                Text(
                                  //요일출력
                                  DateFormat('- EEEE,').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white60),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16.0, color: Colors.white60),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                  fontSize: 85.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                icon,
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '$des',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.black38
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 1.0,
                        color: Colors.grey[500],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, //동일한 간격 설정
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.black45
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              airIcon,
                              const SizedBox(
                                height: 10.0,
                              ),
                              airState,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.black45
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '$dust1',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color: Colors.black45
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'ug/m3',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '$dust2',
                                style: GoogleFonts.lato(
                                    fontSize: 14.0,
                                    color: Colors.black45
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '84.03',
                                style: GoogleFonts.lato(
                                    fontSize: 24.0,
                                    color: Colors.black45
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'ug/m3',
                                style: GoogleFonts.lato(
                                    fontSize: 15.0,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),

                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
