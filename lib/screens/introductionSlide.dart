import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:projet_connected_t_shirt/main.dart';
import 'package:projet_connected_t_shirt/screens/board.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'allData.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "DASHBOARD",
        description: "Access a dashboard that shows your t-shirt data in realtime.",
        pathImage: "assets/images/liveData.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "HISTORY",
        description: "Access information about you last activities, by seeing chart about data stored.",
        pathImage: "assets/images/chart.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "SETTINGS",
        description:
        "Access a settings page, that allows you to change the language, access all data stored, or logout.",
        pathImage: "assets/images/settings.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}