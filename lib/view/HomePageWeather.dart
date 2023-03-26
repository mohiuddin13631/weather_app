import 'dart:async';
import 'dart:convert';

import 'package:api_integration/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
class HomePageWeather extends StatefulWidget {
  const HomePageWeather({Key? key}) : super(key: key);

  @override
  State<HomePageWeather> createState() => _HomePageWeatherState();
}

class _HomePageWeatherState extends State<HomePageWeather> {

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    print("position: ${position!.latitude} position2: ${position!.longitude}");
    weatherApiCall();
    // return await Geolocator.getCurrentPosition();
  }
  Position? position;

  Map<String, dynamic>? weatherData;
  Map<String, dynamic>? weatherForecast;


  weatherApiCall() async
  {
    String weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position!.longitude}&appid=bf881cd668c8bd1799a36d79a42c897b&units=metric&lang=English";
    String forCastUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=${position!.latitude}&lon=${position!.longitude}&appid=bf881cd668c8bd1799a36d79a42c897b&units=metric";
    var weatherResponse = await http.get(Uri.parse(weatherUrl));
    // final data = json.decode(response.body);
    var decodeWeatherData = jsonDecode(weatherResponse.body);

    var forCastResponse = await http.get(Uri.parse(forCastUrl));
    var decodeForCastData = jsonDecode(forCastResponse.body);
    setState(() {
      weatherData = Map<String,dynamic>.from(decodeWeatherData);

      weatherForecast = Map<String,dynamic>.from(decodeForCastData);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();

    Timer.periodic(const Duration(minutes: 2), (timer) {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // print(weatherData);
    return weatherData != null && weatherForecast != null? Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/images/bg.png",),
            image: AssetImage("assets/images/bg_without_house.png",),
            fit: BoxFit.cover,
          )
        ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: size.height*.4,
                  child: Image.asset("assets/images/House.png",scale: 1.3,)),
              Positioned(
                top: 50,
                right: 10,
                child: Text("Country ${weatherData!['sys']['country']}",style: myTextStyle(),),),
              Column(
                children: [
                  SizedBox(height: 98,),

                  Text("${Jiffy(DateTime.now()).format('MMMM do')} ${Jiffy(DateTime.now()).format('h:mm a')}",style: TextStyle(color: Colors.white.withOpacity(.8)),),
                  SizedBox(height: 8,),
                  Text("${weatherData!['name']}",style: myTextStyle(34,FontWeight.w400),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Text("${weatherData!['main']['temp'].toInt()}°",style: myTextStyle(65,FontWeight.w200),),
                      Image.network("https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png",color: Colors.white,),
                      SizedBox(width: 45,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text("${weatherData!['weather'][0]['main']}",style: myTextStyle(20,FontWeight.w400) ,),
                          SizedBox(height: 8,),
                          Text("Feels Like : ${weatherData!['main']['feels_like']}°",style: myTextStyle(16,FontWeight.w400) ,),
                        ],
                      ),
                      SizedBox(width: 25,),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text("Humidity : ${weatherData!['main']['humidity']}\nPressure : ${weatherData!['main']['pressure']}",style: myTextStyle(14,FontWeight.w300,Colors.white.withOpacity(0.7)),),
                          ),

                        ],
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                  SizedBox(height: 12,),

                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 325,
                  width: double.infinity,
                 
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/model.png"),fit: BoxFit.cover)
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
                      Text("Hourly forecast",style:TextStyle(color: Color(0xffEBEBF5).withOpacity(.6),fontSize: 16,fontWeight: FontWeight.w600),),
                      // Text("Hourly forecast",style:TextStyle(color: Colors.white.withOpacity(.6),fontSize: 16),)
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white.withOpacity(.5),
                      ),
                      SizedBox(height: 15,),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        height: 146,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherForecast!['list'].length,
                          itemBuilder: (context, index) {
                            // var vlue = Jiffy(weatherForecast!['list'][index]['dt_txt']).format('h');
                            // var time = int.parse(vlue);
                            // print(time);
                            return SizedBox(
                              width: 65,
                                height: 146,
                              child: Card(
                                // color: Color(0xff48319D),
                                color:Color(0xff48319D).withOpacity(.2),
                                // color:Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(color: Colors.white,width: 1)
                                ),
                                // elevation: 0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(Jiffy(weatherForecast!['list'][index]['dt_txt']).format('h a'),style: TextStyle(color: Colors.white.withOpacity(1)),),
                                    Text(Jiffy(weatherForecast!['list'][index]['dt_txt']).format('d MMM'),style: TextStyle(fontSize: 12,color: Colors.white.withOpacity(.8)),),
                                    Image.network("https://openweathermap.org/img/wn/${weatherForecast!['list'][index]['weather'][0]['icon']}@2x.png",),
                                    Text("${weatherForecast!['list'][index]['main']['temp'].toInt()}°",style: TextStyle(color: Colors.white.withOpacity(.8)),),
                                  ],
                                ),
                              ),
                            );
                        },),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        child: Row(
                          children: [
                          SizedBox(
                          width: size.width*.45,
                          height: 100,
                          child: Card(
                            // color: Color(0xff48319D),
                            color:Color(0xff48319D).withOpacity(.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.white,width: 1)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sunrise",style: myTextStyle(20.0,FontWeight.w400,Colors.white.withOpacity(.6)),),
                                      Spacer(),
                                      Image.asset("assets/images/sunrise_32.png",scale:1,)
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Text("${Jiffy(DateTime.fromMillisecondsSinceEpoch(weatherForecast!['city']['sunrise']*1000)).format('h:mm a')}",style: myTextStyle(20,FontWeight.w400),)
                                ],
                              ),
                            ),
                          ),
                        ),
                            Spacer(),
                            SizedBox(
                              width: size.width*.45,
                              height: 100,
                              child: Card(
                                // color: Color(0xff48319D),
                                color:Color(0xff48319D).withOpacity(.2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.white,width: 1)
                                ),
                                // elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Sunset",style: myTextStyle(20.0,FontWeight.w400,Colors.white.withOpacity(.6)),),
                                          Spacer(),
                                          Image.asset("assets/images/sunset_32.png",scale:1,)
                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Text("${Jiffy(DateTime.fromMillisecondsSinceEpoch(weatherForecast!['city']['sunset']*1000)).format('h:mm a')}",style: myTextStyle(20,FontWeight.w400),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )//todo: Sunrise
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    ):const Center(child: CircularProgressIndicator());
  }
}


