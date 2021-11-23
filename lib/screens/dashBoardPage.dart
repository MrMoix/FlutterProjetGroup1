import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dashBoardPage extends StatefulWidget {
  const dashBoardPage({Key? key}) : super(key: key);

  @override
  _dashBoardPageState createState() => _dashBoardPageState();
}

class _dashBoardPageState extends State<dashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Colors.white60,
          onPressed: (){},
          child: Text("Dashboard"),

        ),
      ),
    );
  }
}
