import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/introductionSlide.dart';
import 'package:projet_connected_t_shirt/screens/allData.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  _settingsPageState createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Language"),
              leading: Icon(Icons.language),
            ),
          ),
          Card(

            child: ListTile(
              title: Text("All data"),
              leading: Icon(Icons.list),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> dataPage()),
                );
              },
            ),
          ),
          Card(

            child: ListTile(
              title: Text("How to use the app?"),
              leading: Icon(Icons.preview),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}

