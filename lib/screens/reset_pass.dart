import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tip_trip/screens/log_in.dart';
import 'package:tip_trip/widgets/snac.dart';

class ResetPassword extends StatefulWidget {
  static const id = 'ResetPassword';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

// ignore: camel_case_types
class _ResetPasswordState extends State<ResetPassword> {
  final resetcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    resetcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [IconButton(onPressed: () {
          Navigator.pushReplacementNamed(context, Login.id);

        }, icon: Icon(Icons.arrow_back))],
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height*.5,
                  child: Image.asset('images/logo.png'),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*.39,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        width: 350,
                        padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,

                          controller: resetcontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(color: Colors.indigo)),
                              labelText: 'Enter Email',
                              labelStyle: TextStyle(fontSize: 20),
                              suffixIcon: Icon(Icons.email, color: Colors.indigo),
                              fillColor: Colors.grey[100],
                              //filled: true
                          ),
                        ),
                      ),

                      // ignore: deprecated_member_use
                      RaisedButton(
                        color: Colors.indigo,
                        onPressed: () async {
                          try{
                            await auth.sendPasswordResetEmail(
                              email: resetcontroller.text).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snac('Check your email'));
                          });
                          Navigator.pushReplacementNamed(context, Login.id);
                          }on FirebaseAuthException catch (e) {

                            if (e.code == 'user-not-found') {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      backgroundColor:
                                      Theme.of(context).backgroundColor,
                                      content: Text("That email not found.",
                                          style: TextStyle(
                                              color: Colors.white)),
                                    );
                                  });
                              print('No user found for that email.');
                            }
                          }

                        },
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text('Reset password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}