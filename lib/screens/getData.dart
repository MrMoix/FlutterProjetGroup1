import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:projet_connected_t_shirt/database/database.dart';
import 'package:intl/intl.dart';
import 'HumidityChartsPage.dart';


class getData extends StatefulWidget {
  const getData({Key? key}) : super(key: key);

  @override
  State<getData> createState() => _getData();
}

class _getData extends State<getData> {
  var cardStyle = TextStyle(
      fontFamily: "Montserrat Regluar", fontSize: 18, color: Colors.black);


  //Variable that get all the data from the t-shirt
  String _dataHumidity = "";
  String _dataTemperature = "";
  String _dataTime = "";
  String _dataFrequence = "";

  //List that will stored one line of data per seconde
  late List<String> temp;

  //Variable for each part of data
  var time;
  var frequence;
  var temperature;
  var humidity;


  Database database = new Database();



  //Methode that will connect the application with the web server in this ip (192.168.4.2) and get the data
  void getData() async {

    //Connect to the server IP
    Response response = await get(Uri.parse('https://tshirtserver-group1.herokuapp.com/'));

    //Store the response body on the list with a split function
    temp = response.body.split(" ");


    //Increment the variables to those different variables
    frequence = temp[1];
    temperature = temp[2];
    humidity = temp[3];

    DateTime currentPhoneDate = DateTime.now();
    final DateFormat formatter = DateFormat('hh:mm:ss');
    final String formattedTime = formatter.format(currentPhoneDate);

    print("NEWTIME ${formattedTime}");

    //Print on the console the data
    print("Data : "+ formattedTime + "  "+ frequence.toString()
        +"  "+ temperature.toString()+"  "+ humidity.toString());

    //Create object to send the data
    myData myTemp = myData(formattedTime, frequence, temperature, humidity);


    //We send the data to firebase event we didn't have the wifi
    database.sendData(myTemp);

    //We set the state of the label that show the data in real time to the application
    setState(() {
      _dataFrequence = frequence.toString();
      _dataHumidity = humidity.toString();
      _dataTemperature = temperature.toString();
      _dataTime = formattedTime.toString();
    });
  }

  //InitState methode that launch the code when the application in starting
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //We increment a timer every 2 secondes the get the data and we put the get data methode inside the timer
    Timer mytimer = Timer.periodic(Duration(seconds: 5), (timer) {

      //Methode that get all data
      getData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

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
                    color: (_dataFrequence.length!=0) ?(int.parse(_dataFrequence)>100) ? Colors.red : Colors.lightGreen : Colors.white,
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
                          "${(_dataFrequence.length!=0) ? "$_dataFrequence BPM": "Not connected"}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: (_dataTemperature.length!=0) ?(int.parse(_dataTemperature)>0) ? Colors.orangeAccent : Colors.amber : Colors.white,
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
                          "${(_dataTemperature.length!=0) ? "$_dataTemperature °C": "Not connected"}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: (_dataHumidity.length!=0) ?(int.parse(_dataHumidity)>50) ? Colors.red : Colors.blue : Colors.white,
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
                          "${(_dataHumidity.length!=0) ? "$_dataHumidity % of Humidity" : "Not connected"}",
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
                        color: Colors.white70,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              size: 85.0,
                            ),
                            Text(
                              "${(_dataTime.length!=0) ? _dataTime : "Not connected"}",
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