import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_connected_t_shirt/screens/introductionSlide.dart';
import 'package:projet_connected_t_shirt/screens/allData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              title: Text(AppLocalizations.of(context)!.language),
              leading: Icon(Icons.language),
            ),
          ),
          Card(

            child: ListTile(
              title: Text(AppLocalizations.of(context)!.allData),
              leading: Icon(Icons.list),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> dataPage()),
                );
              },
            ),
          ),
          Card(

            child: ListTile(
              title: Text(AppLocalizations.of(context)!.howToUseTheApp),
              leading: Icon(Icons.preview),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.logout),
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

