import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/FrequencyChartsPage.dart';
import 'package:projet_connected_t_shirt/screens/HumidityChartsPage.dart';
import 'package:projet_connected_t_shirt/screens/TemperatureChartsPage.dart';


class chartsPage extends StatefulWidget {
  const chartsPage({Key? key}) : super(key: key);

  @override
  _chartsPageState createState() => _chartsPageState();
}

class _chartsPageState extends State<chartsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(
            label: "Frequency",
            icon: Icon(
              Icons.query_stats,
            ),
        ),
        BottomNavigationBarItem(
            label: "Humidity",
            icon: Icon(Icons.ac_unit)
        ),
        BottomNavigationBarItem(
            label: "Temperature",
            icon: Icon(Icons.thermostat,
            ),
        ),
      ],
    ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: "Frequency",
              builder: (context) => const Frequency(),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: "Humidity",
              builder: (context) => const Humidity(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: "Temperature",
              builder: (context) => const Temperature(),
            );
          default:
            assert(false, 'Unexpected tab');
            return const SizedBox.shrink();
        }
      },
    );
  }
}
