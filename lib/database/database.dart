import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';
import 'package:projet_connected_t_shirt/screens/getData.dart';
import '../main.dart';


//Create the class database
class Database
{
  late final DatabaseReference _messagesRef;
  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
  Database(){
    //DateTime
    DateTime currentPhoneDate = DateTime.now();
    myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    _messagesRef =
    FirebaseDatabase.instance.reference().child('Customer').child(uid).child(myTimeStamp.seconds.toString());
    print('Create timestamp  ${myTimeStamp.seconds.toString()}');
  }

  //Methode that send the data to firebase
  void sendData(myData data) {
    _messagesRef.push().set(data.toJson(myTimeStamp.seconds.toString()));
  }
}