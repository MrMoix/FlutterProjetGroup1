import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/history.dart';
import 'package:projet_connected_t_shirt/screens/board.dart';
import 'package:projet_connected_t_shirt/screens/login.dart';
import 'package:projet_connected_t_shirt/screens/allData.dart';
import 'package:projet_connected_t_shirt/screens/settings.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LandingPage());
  }
}
class tabBar extends StatelessWidget {
  const tabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            bottom: const TabBar(

              tabs: [

                Tab(
                  icon: Icon(Icons.dashboard),
                  text: 'Board',
                ),
                Tab(
                  icon: Icon(Icons.trending_up),
                  text: 'History',
                ),

                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Settings',
                ),
              ],
            ),
            title: const Text('Connected T-Shirt'),

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
            return const Scaffold(
              body: Center(
                child: Text("Error"),
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
                return const Scaffold(
                  body: Center(
                    child: Text("Checking Auth"),
                  ),
                );
              },
            );
          }
          return const Scaffold(
            body: Center(
              child: Text("Connected"),
            ),
          );
        });

  }

}