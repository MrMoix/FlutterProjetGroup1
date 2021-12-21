import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';

class dataPage extends StatefulWidget {
  const dataPage({Key? key}) : super(key: key);

  @override
  _dataPageState createState() => _dataPageState();
}

class _dataPageState extends State<dataPage> {
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
      var userKey = snap.key;
      userData.forEach((key, value)  {
        ref
            .child('Customer')
        //This child has to be the connected user ID
            .child(userKey!).child(key)
            .once()
            .then((DataSnapshot snap) {
          //I have to count the children element here :
          Map activityData = snap.value;
          activityData.forEach((key, value)  {
            myData test = myData.fromJson(value);
            allData.add(test);
          });
          setState(() {

          });
        });
      });
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [_createDataTable()],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      dividerThickness: 3,
      columnSpacing: 4.5,
      dataRowHeight: 55,
      showBottomBorder: true,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Time')),
      DataColumn(label: Text('Frequence')),
      DataColumn(label: Text('Temperature')),
      DataColumn(label: Text('Humidity'))
    ];
  }

  List<DataRow> _createRows() {
    return allData
        .map((value) => DataRow(cells: [
              DataCell(Text(value.time)),
              DataCell(Text(value.frequence)),
              DataCell(Text(value.temperature)),
              DataCell(Text(value.humidity))
            ]))
        .toList();
  }
}
