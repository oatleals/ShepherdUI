import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/UI/common.dart';
import 'package:shepherd/controllers/ClockController.dart';

import '../errors.dart';

class LoginPageOTP extends StatefulWidget {
  @override
  _LoginPageOTPState createState() => _LoginPageOTPState();
}

class _LoginPageOTPState extends State<LoginPageOTP> {
  @override
  Widget build(BuildContext context) {
    final otpTextEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blue[200], //Colors.blue[200]
      body: SingleChildScrollView(
        padding:EdgeInsets.all(24.0) ,
        dragStartBehavior: DragStartBehavior.down,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset('assets/logo.png', scale: 1.5),
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
                controller: otpTextEditingController,
                decoration: InputDecoration(
                    labelText: "One Time Password",
                    labelStyle: TextStyle(fontSize: 20),
                    filled: true),
              ),
              Column(
                children: <Widget>[
                  ButtonTheme(
                    height: 50,
                    disabledColor: Colors.blueAccent,
                    child: ElevatedButton(
                      //disabledElevation: 4.0,
                      onPressed: () async
                      {
                        final prefs = await SharedPreferences.getInstance();
                        final userId = prefs.getInt('userId');
                        final status = await requestOTPEmail(userId);

                        if (status != ERROR.success)
                          showSnackbar(context, status);
                      },
                      child: Text(
                        'Request OTP',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: 50,
                    disabledColor: Colors.blueAccent,
                    child: ElevatedButton(
                      //disabledElevation: 4.0,
                      onPressed: () async
                      {
                        final prefs = await SharedPreferences.getInstance();
                        int userId = prefs.getInt('userId');
                        var otp;
                        try {
                          otp = int.parse(otpTextEditingController.text);
                        }
                        catch(_) {
                          otp = -1;
                        }

                        final status = await verifyOTP(otp, userId);

                        status == ERROR.success ?
                         Navigator.of(context).pushReplacementNamed("/Home")
                         : showSnackbar(context, status);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
