import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:projet_connected_t_shirt/screens/HumidityChartsPage.dart';

class dashBoardPage extends StatefulWidget {
  const dashBoardPage({Key? key}) : super(key: key);

  @override
  _dashBoardPageState createState() => _dashBoardPageState();
}

class _dashBoardPageState extends State<dashBoardPage> {
  var cardStyle = TextStyle(
      fontFamily: "Montserrat Regluar", fontSize: 18, color: Colors.black);

  List<myData> allData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    ref
        .child('Customer')
        //This child has to be the connected user ID
        .child(uid)
    .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      Map userData = snap.value;
      allData.clear();
      userData.forEach((key, value) {
        for(var i = 0; i < value.length; i++){
          myData d = new myData(
            value.elementAt(i)['time'],
            value.elementAt(i)['frequency'],
            value.elementAt(i)['temperature'],
            value.elementAt(i)['humidity'],
          );
          allData.add(d);
        }
      });
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
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
                          "${(allData.length != 0) ? allData[allData.length - 1].frequence : "No data"} BPM ",
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
                          "${(allData.length != 0) ? allData[allData.length - 1].temperature : "No data"}°C",
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
                          "${(allData.length != 0) ? allData[allData.length - 1].humidity : "No data"}% of Humidity",
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
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: 85.0,
                            ),
                            Text(
                              "${(allData.length != 0) ? allData[allData.length - 1].time : "No data"}",
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
