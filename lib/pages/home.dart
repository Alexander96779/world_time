import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    // set background image
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    // set scaffold bg color
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                OutlinedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[200],
                    ),
                    label: Text(
                        'Edit location',
                      style: TextStyle(
                        color: Colors.grey[200]
                      ),
                    ),
                  style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey)
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                data['time'] == 'Error getting time, Try again.' ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data['time'],
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.red,
                          fontWeight: FontWeight.bold
                      ),
                    )
                    ]
                    )
                    :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                      data['time'],
                      style: TextStyle(
                          fontSize: 66.0,
                          letterSpacing: 2.0,
                          color: Colors.white
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
