import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/HumidityChartsPage.dart';

class dashBoardPage extends StatefulWidget {
  const dashBoardPage({Key? key}) : super(key: key);

  @override
  _dashBoardPageState createState() => _dashBoardPageState();
}

class _dashBoardPageState extends State<dashBoardPage> {
  var cardStyle = TextStyle(
      fontFamily: "Montserrat Regluar", fontSize: 18, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(),
          Expanded(
            child: GridView.count(
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                primary: false,
                children: <Widget>[
                  Card(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.query_stats,
                          size: 85.0,
                        ),
                        Text(
                          "65 BPM ",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.thermostat,
                          size: 85.0,
                        ),
                        Text(
                          "26°C",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.ac_unit,
                          size: 85.0,
                        ),
                        Text(
                          "17% of Humidity",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                   child: new InkWell(
                       onTap: () => Humidity(),


                     child: new Container(
                    color: Colors.red,

                    child:  new Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.list,
                          size: 85.0,
                        ),
                        Text(
                          "All Data",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  ),
                  ),
                ],
                crossAxisCount: 2),
          ),
        ],
      ),
    );
  }
}
