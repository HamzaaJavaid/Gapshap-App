import 'dart:ui' ;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';
class geolocator {

  late double longitude ;
  late double latitude ;
  late String weather_description;
  late double city_temp;
  late String country;
  late String city_name;


  Future get_current_location() async{



    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);


    longitude = position.longitude;
    latitude = position.latitude;

    print("$longitude");
    print("$latitude");

    Uri uri = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=42907fffb3b53173794816eeed01a639&units=metric');

    Response response = await get(uri);
    print(response.body);

    

     weather_description = jsonDecode(response.body)['weather'][0]['description'];
     city_temp = jsonDecode(response.body)['main']['temp'];
     country = jsonDecode(response.body)['sys']['country'];
     city_name = jsonDecode(response.body)['name'];

    //
    // print(weather_description);
    // print(city_temp);
    // print(country);
    // print(city_name);
    //

  }




    }






