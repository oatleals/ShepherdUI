import 'package:flutter/gestures.dart';
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
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/logo.png', scale: 1.5,),
                    Text(
                      'Shepherd Login',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
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
        ),
      ),
    );
  }
}
