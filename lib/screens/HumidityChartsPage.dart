import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Humidity extends StatefulWidget {
  const Humidity({Key? key}) : super(key: key);

  @override
  _HumidityState createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Humidity"),
    );
  }
}
