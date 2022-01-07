import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projet_connected_t_shirt/screens/history.dart';
import 'package:projet_connected_t_shirt/screens/board.dart';
import 'package:projet_connected_t_shirt/screens/login.dart';
import 'package:projet_connected_t_shirt/screens/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connected T-Shirt',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('de', ''), // Spanish, no country code
      ],
      home: LandingPage(),
    );
  }
}
class tabBar extends StatelessWidget {
  const tabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('de', ''), // Spanish, no country code
      ],
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            bottom: TabBar(

              tabs: [

                Tab(
                  icon: Icon(Icons.dashboard),
                  text: AppLocalizations.of(context)!.board,
                ),
                Tab(
                  icon: Icon(Icons.trending_up),
                  text: AppLocalizations.of(context)!.history,
                ),

                Tab(
                  icon: Icon(Icons.settings),
                  text: AppLocalizations.of(context)!.settings,
                ),
              ],
            ),
            title: Text(AppLocalizations.of(context)!.connectedTshirt),

          ),
          backgroundColor: Colors.blueGrey,
          body: TabBarView(
            children: [
              getData(),
              chartsPage(),
              settingsPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(context)!.error),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  Object? user = snapshot.data;
                  if (user == null) {
                    return LoginPage();
                  } else {
                    return tabBar();

                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text(AppLocalizations.of(context)!.checkingAuth),
                  ),
                );
              },
            );
          }
          return Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.connected),
            ),
          );
        });

  }

}