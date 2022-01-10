import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projet_connected_t_shirt/data/myData.dart';

//Create the class database
class Database
{
  late final DatabaseReference _messagesRef;
  Database(){
    //DateTime
    DateTime currentPhoneDate = DateTime.now();
    final myTimeStamp = currentPhoneDate.millisecondsSinceEpoch; //To TimeStamp
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    _messagesRef =
    FirebaseDatabase.instance.reference().child('Customer').child(uid).child(myTimeStamp.toString());
    print('Create timestamp  ${myTimeStamp}');
  }

  //Methode that send the data to firebase
  void sendData(myData data) async{
    await _messagesRef.push().set(data.toJson());
  }
}