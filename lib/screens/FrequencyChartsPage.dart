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
        .child("tshirt")
        .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      List<dynamic> data = snap.value;
      allData.clear();
      //The for loop has to loop until the table size
      for (var i = 0; i < data.length; i++) {
        myData d = new myData(
          data[i]['time'],
          data[i]['frequence'],
          data[i]['temperature'],
          data[i]['humidity'],
        );
        allData.add(d);
      }
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
                      LineSeries<myData, num>(

                          dataSource: allData,
                          xValueMapper: (myData dataRow, _) => DateTime(2021,1,1, int.parse(dataRow.time.substring(0, 2)), int.parse(dataRow.time.substring(3, 4))).millisecondsSinceEpoch,
                          yValueMapper: (myData dataRow, _) => double.parse(dataRow.frequence),
                          dataLabelSettings: DataLabelSettings(isVisible: true)
                      )
                    ],
                    primaryXAxis: CategoryAxis(isVisible: true),
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
                      LineSeries<myData, num>(

                          dataSource: allData,
                          xValueMapper: (myData dataRow, _) => DateTime(2021,1,1, int.parse(dataRow.time.substring(0, 2)), int.parse(dataRow.time.substring(3, 4))).millisecondsSinceEpoch,
                          yValueMapper: (myData dataRow, _) => double.parse(dataRow.frequence),
                          dataLabelSettings: DataLabelSettings(isVisible: true)
                      )
                    ],
                    primaryXAxis: CategoryAxis(isVisible: true),
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


