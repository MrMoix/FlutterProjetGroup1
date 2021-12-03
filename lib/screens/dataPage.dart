import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        .child("tshirt")
        .once()
        .then((DataSnapshot snap) {
      //I have to count the children element here :
      var keys = snap.value;
      var data = snap.value;
      allData.clear();

      //The for loop has to loop until the table size
      for (var i = 0; i < 266; i++) {
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
        .map((book) => DataRow(cells: [
              DataCell(Text(book.time)),
              DataCell(Text(book.frequence)),
              DataCell(Text(book.temperature)),
              DataCell(Text(book.humidity))
            ]))
        .toList();
  }
}
