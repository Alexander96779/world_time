import 'dart:ffi';

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  late String  time;
  String flag;
  String url;
  late bool isDayTime = false;

  WorldTime({ required this.location, required this.flag, required this.url});

  Future <void> getTime() async{
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time  = DateFormat.jm().format(now);
    } catch(e) {
      time = 'Error getting time, Try again.';
    }
  }
}