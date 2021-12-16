import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Frequency extends StatefulWidget {
  const Frequency({Key? key}) : super(key: key);
  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  List<myData> allData = [];
  late int year, month, day;

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
        .child("1639645777327")
        .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      Map userData = snap.value;
      var userKey = snap.key;
      final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(int.parse(userKey!));
      year = date1.year;
      month = date1.month;
      day = date1.day;
      print("le jour est ${year} ${month} ${day}");
      userData.forEach((key, value)  {
        print("value : ${value}");
        myData data = myData.fromJson(value);
        allData.add(data);
      });
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 250,
                  width: 400,
                  child:SfCartesianChart(

                    title: ChartTitle(text: 'Heartbeat History Hourly'),
                    legend: Legend(isVisible: false),
                    series: <ChartSeries>[
                      LineSeries<myData, DateTime>(
                          dataSource: allData,
                          xValueMapper: (myData dataRow, _) => DateTime(year,month,day, int.parse(dataRow.time.substring(0, 2)), int.parse(dataRow.time.substring(3, 5)), int.parse(dataRow.time.substring(6, 8))),
                          yValueMapper: (myData dataRow, _) => double.parse(dataRow.frequence)
                      )
                    ],
                    primaryXAxis: DateTimeAxis(isVisible: true),
                    primaryYAxis: NumericAxis(numberFormat: NumberFormat("###")),
                  ),
                ),
                Container(
                  height: 250,
                  width: 400,
                  child:SfCartesianChart(

                    title: ChartTitle(text: 'Heartbeat Max/Min Daily'),
                    legend: Legend(isVisible: false),
                    series: <ChartSeries>[
                      LineSeries<myData, DateTime>(

                          dataSource: allData,
                          xValueMapper: (myData dataRow, _) => DateTime(year,month,day, int.parse(dataRow.time.substring(0, 2)), int.parse(dataRow.time.substring(3, 5)), int.parse(dataRow.time.substring(6, 8))),
                          yValueMapper: (myData dataRow, _) => double.parse(dataRow.frequence)
                      )
                    ],
                    primaryXAxis: DateTimeAxis(isVisible: true),
                    primaryYAxis: NumericAxis(numberFormat: NumberFormat("###")),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

}


