import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class plotsPage extends StatefulWidget {
  const plotsPage({Key? key}) : super(key: key);

  @override
  _plotsPageState createState() => _plotsPageState();
}

class _plotsPageState extends State<plotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.blueGrey,
          onPressed: (){


          },
          child: Text("Plots"),
        ),
      ),
    );
  }
}
