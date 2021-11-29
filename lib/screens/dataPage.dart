import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dataPage extends StatefulWidget {
  const dataPage({Key? key}) : super(key: key);

  @override
  _dataPageState createState() => _dataPageState();
}

class _dataPageState extends State<dataPage> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final databaseRef = FirebaseDatabase.instance.reference();

  void printFirebase() {
    databaseRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
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
  List<Map> _datatshirt = [
    {
      "Time": "1:01:01",
      "Frequence": "45",
      "temperature": "28",
      "humidity": "17"
    },
    {
      "Time": "2:01:01",
      "Frequence": "46",
      "temperature": "29",
      "humidity": "17"
    },
    {
      "Time": "3:01:01",
      "Frequence": "47",
      "temperature": "30",
      "humidity": "17"
    },
    {
      "Time": "4:01:01",
      "Frequence": "48",
      "temperature": "31",
      "humidity": "17"
    },
    {
      "Time": "5:01:01",
      "Frequence": "49",
      "temperature": "32",
      "humidity": "17"
    },
    {
      "Time": "6:01:01",
      "Frequence": "50",
      "temperature": "33",
      "humidity": "17"
    },
    {
      "Time": "3:01:01",
      "Frequence": "47",
      "temperature": "30",
      "humidity": "17"
    },
    {
      "Time": "4:01:01",
      "Frequence": "48",
      "temperature": "31",
      "humidity": "17"
    },
    {
      "Time": "5:01:01",
      "Frequence": "49",
      "temperature": "32",
      "humidity": "17"
    },
    {
      "Time": "6:01:01",
      "Frequence": "50",
      "temperature": "33",
      "humidity": "17"
    },
    {
      "Time": "3:01:01",
      "Frequence": "47",
      "temperature": "30",
      "humidity": "17"
    },
    {
      "Time": "4:01:01",
      "Frequence": "48",
      "temperature": "31",
      "humidity": "17"
    },
    {
      "Time": "5:01:01",
      "Frequence": "49",
      "temperature": "32",
      "humidity": "17"
    },
    {
      "Time": "6:01:01",
      "Frequence": "50",
      "temperature": "33",
      "humidity": "17"
    },
  ];
  return _datatshirt
      .map((book) => DataRow(cells: [

            DataCell(Text(book['Time'])),
            DataCell(Text(book['Frequence'])),
            DataCell(Text(book['temperature'])),
            DataCell(Text(book['humidity']))
          ]))
      .toList();
}
