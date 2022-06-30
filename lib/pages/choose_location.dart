import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChooseLocation extends StatefulWidget {

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final continents = ['Africa', 'America', 'Antarctica', 'Asia', 'Australia', 'Europe'];
  String ? continent;
  String ? city;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
            fontSize: 16.0
        ),
      )
  );

  void checkTime() async {
    final pattern = RegExp('\\s+');
    String? newCity = city?.replaceAll(pattern, "_");
    if (city != null && continent != null) {
      String url = continent! + '/' + newCity!;
      WorldTime instance = new WorldTime(
          location: '$city', flag: 'default.png', url: '$url');
      await instance.getTime();
      //  navigate back to home page
      Navigator.pop(context, {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime
      });
    } else{
      Fluttertoast.showToast(
          msg: 'All fields are required',
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red[800],
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Choose Location'),
        centerTitle: true,
      ),
      body:  GestureDetector(
        onTap: () {
        FocusScope.of(context).unfocus();
        },
      child: Container(
        color: Colors.grey[200],
        height: 600,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Some cities may not be found because we only use canonical timezones.',
                        style: TextStyle(
                          color: Colors.grey
                        )
                  ),
                  SizedBox(height: 30.0,),
                  Text('Choose Continent',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      )),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: continent,
                        isExpanded: true,
                        iconSize: 36,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                        items: continents.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() { continent = value; }),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text('Add City',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                      )),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Add City",
                        labelText: "City",
                        labelStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[900]
                        ),
                        border: OutlineInputBorder()
                    ),
                    onChanged: (value) => setState(() { city = value; }),

                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    child: Text(
                      'Check Time',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 50),
                        primary: Colors.grey[900]
                    ),
                    onPressed: () {
                      checkTime();
                    },
                  )
                ]
            ),
          ),
        ),
      ),
      ),
    );

  }
}
