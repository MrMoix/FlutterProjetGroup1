import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _createUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  late String _email;
  late String _password;

  Future<void> _createUser() async {

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _loginUser() async {

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              onChanged: (value){
                _email =value;
              },

              decoration: InputDecoration(hintText: "Enter Email"),

            ),
            TextField(

              enableSuggestions: false,
              autocorrect: false,
              onChanged: (value){
                  _password =value;
                },
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: "Enter Password",
                suffixIcon:IconButton(
                  icon:  Icon(
                    _isObscure ? Icons.visibility  :Icons.visibility_off
                  ),
                  onPressed: (){
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: _createUser,
                  child: Text("Create Account"),
                ),
                MaterialButton(
                  onPressed: _loginUser
                  ,
                  child: Text("Login"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
