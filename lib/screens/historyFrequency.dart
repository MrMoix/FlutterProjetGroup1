import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Frequency extends StatefulWidget {
  const Frequency({Key? key}) : super(key: key);
  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  List<myData> allData = [];
  late int year, month, day;
  String dropdownValue = 'Select activities';
  List<String> keyData = ['Select activities'];
  late ZoomPanBehavior _zoomPanBehavior;
  int max = 0;
  int min = 500;

  var cardStyle = TextStyle(
      fontFamily: "Montserrat Regluar", fontSize: 20, color: Colors.black);
  late DatabaseReference ref;
  late final FirebaseAuth auth;
  late final User user;
  late final uid;

  @override
  void initState() {
    ref = FirebaseDatabase.instance.reference();
    auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    uid = user!.uid;
    _getActivityKeys();
    _zoomPanBehavior = ZoomPanBehavior(
      // Enables pinch zooming
      enablePinching: true,
      enablePanning: true,
    );
  }

  void _getActivityKeys() {
    ref
        .child('Customer')
        //This child has to be the connected user ID
        .child(uid)
        .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      Map activityData = snap.value;
      var userKey = snap.key;
      activityData.forEach((key, value) {
        ref
            .child('Customer')
            //This child has to be the connected user ID
            .child(userKey!)
            .child(key)
            .once()
            .then((DataSnapshot snap) {
          //I have to count the children element here :
          Map timeData = snap.value;
          var timKey = snap.key;
          keyData.add(DateTime.fromMillisecondsSinceEpoch(int.parse(timKey!))
              .toString());
          setState(() {

          });
        });
      });
      setState(() {});
    });
  }

  void _getActivityData(String activity) {
    ref
        .child('Customer')
        //This child has to be the connected user ID
        .child(uid)
        .child(activity)
        .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      Map userData = snap.value;
      var userKey = snap.key;
      final DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(userKey!));
      year = date.year;
      month = date.month;
      day = date.day;
      userData.forEach((key, value) {
        myData data = myData.fromJson(value);
        allData.add(data);
      });
      max = 0;
      min = 500;
      userData.forEach((key, value) {
        if (int.parse(value['frequence']) > max) {
          max = int.parse(value['frequence']);
        }
        if (int.parse(value['frequence']) < min) {
          min = int.parse(value['frequence']);
        }
        ;
      });
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 1,
                color: Colors.deepOrange,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  allData.clear();
                  dropdownValue = newValue!;
                  DateTime date = DateTime.parse(newValue);
                  var timeStand = date.millisecondsSinceEpoch;
                  _getActivityData(timeStand.toString());
                });
              },
              items: (keyData.length == 0
                      ? <String>["Select activities"]
                      : keyData)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
            Container(
              constraints: BoxConstraints(minHeight: 250, minWidth: 400),
              child: SfCartesianChart(
                zoomPanBehavior: _zoomPanBehavior,
                title: ChartTitle(text: AppLocalizations.of(context)!.heartbeatActivity),
                legend: Legend(isVisible: false),
                series: <ChartSeries>[
                  LineSeries<myData, DateTime>(
                      dataSource: allData,
                      xValueMapper: (myData dataRow, _) => DateTime(
                          year,
                          month,
                          day,
                          int.parse(dataRow.time.substring(0, 2)),
                          int.parse(dataRow.time.substring(3, 5)),
                          int.parse(dataRow.time.substring(6, 8))),
                      yValueMapper: (myData dataRow, _) =>
                          double.parse(dataRow.frequence))
                ],
                primaryXAxis: DateTimeAxis(isVisible: true, dateFormat : DateFormat("hh:mm:ss")),
                primaryYAxis: NumericAxis(numberFormat: NumberFormat("###")),
              ),
            )
          ],
        ),
        Container(
          constraints: BoxConstraints(minHeight: 100, minWidth: double.infinity, maxHeight: 400),
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
                  child: new InkWell(
                    onTap: () {
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.minimumValue + ": ",
                          style: cardStyle,
                        ),
                        Text(
                          (min == 500) ? AppLocalizations.of(context)!.noActivitySelected : "${min} BPM",
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
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.maximumValue + " : ",
                          style: cardStyle,
                        ),
                        Text(
                          (max == 0) ? AppLocalizations.of(context)!.noActivitySelected : "${max} BPM",
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
    ));
  }
}
