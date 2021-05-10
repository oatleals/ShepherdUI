import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/UI/common.dart';
import 'package:shepherd/controllers/ClockController.dart';

import '../errors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final employeeIDTextEditingController = TextEditingController();
    final emailTextEditingController = TextEditingController();
    
    return Scaffold(
      backgroundColor: Colors.blue[200], //Colors.blue[200]
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 10), //this moves the logo up or down
                Image.asset('assets/logo.png'),
                SizedBox(height: 40),
                Text(
                  'Sheppard Login',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 60.0),
            TextField(
              controller: employeeIDTextEditingController,
              decoration: InputDecoration(
                  labelText: "User ID",
                  labelStyle: TextStyle(fontSize: 20),
                  filled: true),
            ),
            TextField(
              controller: emailTextEditingController,
              decoration: InputDecoration(
                  labelText: "Email Address",
                  labelStyle: TextStyle(fontSize: 20),
                  filled: true),
            ),
            SizedBox(height: 60.0),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 50,
                  disabledColor: Colors.blueAccent,
                  child: ElevatedButton(
                    onPressed: () async
                    {
                      final prefs = await SharedPreferences.getInstance();
                      final email = emailTextEditingController.text;
                      var employeeId;
                      try {
                        employeeId = int.parse(employeeIDTextEditingController.text);
                      }
                      catch(_) {
                        employeeId = -1;
                      }
                      prefs.setInt('userId', employeeId);


                      var status = await requestEmailConfirmation(email, employeeId);                      
                      if (status == ERROR.success)
                        Navigator.of(context).pushReplacementNamed("/LoginOTP");
                      else 
                        showSnackbar(context, status);
                    },
                    child: Text(
                      'Request Email Verification',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
