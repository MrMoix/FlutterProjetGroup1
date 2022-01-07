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
        title: AppLocalizations.of(context)!.dashboardTitle,
        description: AppLocalizations.of(context)!.dashboardDescription,
        pathImage: "assets/images/liveData.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context)!.historyTitle,
        description: AppLocalizations.of(context)!.historyDescription,
        pathImage: "assets/images/chart.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: AppLocalizations.of(context)!.settingsTitle,
        description: AppLocalizations.of(context)!.settingsDescription,
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