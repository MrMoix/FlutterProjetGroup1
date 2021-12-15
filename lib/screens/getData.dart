import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:projet_connected_t_shirt/database/database.dart';


class getData extends StatefulWidget {
  const getData({Key? key}) : super(key: key);

  @override
  State<getData> createState() => _getData();
}

class _getData extends State<getData> {

  //Variable that get all the data from the t-shirt
  String _data = "";

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
    time = temp[0];
    frequence = temp[1];
    temperature = temp[2];
    humidity = temp[3];

    //Print on the console the data
    print("Data : "+ time.toString()+ "  "+ frequence.toString()
        +"  "+ temperature.toString()+"  "+ humidity.toString());

    //Create object to send the data
    myData myTemp = myData(time, frequence, temperature, humidity);


    //We send the data to firebase event we didn't have the wifi
    database.sendData(myTemp);

    //We set the state of the label that show the data in real time to the application
    setState(() {

      _data = "Data : "+ time.toString()+ "  "+ frequence.toString()
          +"  "+ temperature.toString()+"  "+ humidity.toString();

    });

  }

  //InitState methode that launch the code when the application in starting
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //We increment a timer every 2 secondes the get the data and we put the get data methode inside the timer
    Timer mytimer = Timer.periodic(Duration(seconds: 2), (timer) {

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

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You can see de t-shirt data in real time',
            ),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}