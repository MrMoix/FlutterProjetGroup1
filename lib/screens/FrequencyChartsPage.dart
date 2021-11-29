import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Frequency extends StatefulWidget {
  const Frequency({Key? key}) : super(key: key);

  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Frequency"),
    );
  }
}
