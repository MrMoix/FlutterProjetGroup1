import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/historyFrequency.dart';
import 'package:projet_connected_t_shirt/screens/historyHumidity.dart';
import 'package:projet_connected_t_shirt/screens/historyTemperature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
            label: AppLocalizations.of(context)!.frequence,
            icon: Icon(
              Icons.query_stats,
            ),
        ),
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.humidity,
            icon: Icon(Icons.ac_unit)
        ),
        BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.temperature,
            icon: Icon(Icons.thermostat,
            ),
        ),
      ],
    ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: AppLocalizations.of(context)!.frequence,
              builder: (context) => const Frequency(),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: AppLocalizations.of(context)!.humidity,
              builder: (context) => const Humidity(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: AppLocalizations.of(context)!.temperature,
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
