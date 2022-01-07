import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:projet_connected_t_shirt/database/database.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class getData extends StatefulWidget {
  const getData({Key? key}) : super(key: key);

  @override
  State<getData> createState() => _getData();
}

class _getData extends State<getData> {
  var cardStyle = TextStyle(
      fontFamily: "Montserrat Regluar", fontSize: 18, color: Colors.black);

  late Timer myTimer;

  //Variable that get all the data from the t-shirt
  String _dataHumidity = "";
  String _dataTemperature = "";
  String _dataTime = "";
  String _dataFrequence = "";

  String url = "https://tshirtserver-group1.herokuapp.com/";

  bool timerStart = false;
  int activityCount = 0;

  //List that will stored one line of data per seconde
  late List<String> temp;

  //Variable for each part of data
  var time;
  var frequence;
  var temperature;
  var humidity;

  Future<void> startGetttingData() async {
    bool result = await testConnection();
    if(result == true) {
      showDialog(context: context,
          builder: (BuildContext context) =>
              _buildPopupDialog(context, AppLocalizations.of(context)!.activityStarted,
                  AppLocalizations.of(context)!.activityStartConfirmation));
      activityCount = 1;
      timerStart = true;
      Database database = new Database();
      myTimer = Timer.periodic(Duration(seconds: 5), (timer) {
        //Methode that get all data
        getData(database);
      });
    }
  }

  Future<bool> testConnection() async{
    try {
      final response = await http.get(Uri.parse(url));
    } on Exception {
      return false;
    }
    return true;
  }

  //Methode that will connect the application with the web server in this ip (192.168.4.2) and get the data
  void getData(Database database) async {
    final response = await http.get(Uri.parse(url));
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
    print("Data : " +
        formattedTime +
        "  " +
        frequence.toString() +
        "  " +
        temperature.toString() +
        "  " +
        humidity.toString());

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
  }

  @override
  void dispose() {
    super.dispose();
    if(activityCount == 1){
      myTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: size.height, maxWidth: size.width),
            child: GridView.count(
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                primary: false,
                children: <Widget>[
                  Card(

                    color: (_dataFrequence.length != 0)
                        ? (int.parse(_dataFrequence) > 100)
                            ? Colors.redAccent
                            : Colors.yellowAccent
                        : Colors.white,
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
                          "${(_dataFrequence.length != 0) ? "$_dataFrequence BPM" : AppLocalizations.of(context)?.notConnected}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: (_dataTemperature.length != 0)
                        ? (int.parse(_dataTemperature) > 0)
                            ? Colors.yellowAccent
                            : Colors.redAccent
                        : Colors.white,
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
                          "${(_dataTemperature.length != 0) ? "$_dataTemperature °C" : AppLocalizations.of(context)?.notConnected}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: (_dataHumidity.length != 0)
                        ? (int.parse(_dataHumidity) > 50)
                            ? Colors.redAccent
                            : Colors.yellowAccent
                        : Colors.white,
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
                          "${(_dataHumidity.length != 0) ? "$_dataHumidity %" : AppLocalizations.of(context)?.notConnected}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          size: 85.0,
                        ),
                        Text(
                          "${(_dataTime.length != 0) ? _dataTime : AppLocalizations.of(context)?.notConnected}",
                          style: cardStyle,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: new InkWell(
                      onTap: () async {
                          if(activityCount == 0){
                          startGetttingData();
                          }else{
                            showDialog(context: context,
                                builder: (BuildContext context)=>_buildPopupDialog(context, AppLocalizations.of(context)!.cantStartActivity, AppLocalizations.of(context)!.alreadyStarted) );
                          }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            size: 85.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.start,
                            style: cardStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: new InkWell(
                      onTap: () {
                        print(AppLocalizations.of(context)!.stop);
                        if(timerStart == false || activityCount == 0){
                          showDialog(context: context,
                              builder: (BuildContext context)=>_buildPopupDialog(context, AppLocalizations.of(context)!.noActivityToStop, AppLocalizations.of(context)!.startFirst) );
                        }else {
                          stopActivity();
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.close,
                            size: 85.0,
                          ),
                          Text(
                            AppLocalizations.of(context)!.stop,
                            style: cardStyle,
                          ),
                        ],
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

  Widget _buildPopupDialog(BuildContext context, String title, String message) {
    return new AlertDialog(
      title: Text(title),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(AppLocalizations.of(context)!.close),
        ),
      ],
    );
  }

  void stopActivity() {
    showDialog(context: context,
        builder: (BuildContext context)=>_buildPopupDialog(context, AppLocalizations.of(context)!.activityStopped, AppLocalizations.of(context)!.activityStopConfirmation) );
    activityCount = 0;
    myTimer.cancel();
  }
}
