import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/homepage.dart';
import 'package:projet_connected_t_shirt/screens/loginpage.dart';

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
                    return HomePage();
                    return const Scaffold(
                      body: Center(
                        child: Text("Checking Auth"),
                      ),
                    );
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
