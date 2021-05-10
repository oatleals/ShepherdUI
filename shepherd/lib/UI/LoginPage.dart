import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final employeeIDTextEditingController = TextEditingController();
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
              decoration: InputDecoration(
                  labelText: "User ID",
                  labelStyle: TextStyle(fontSize: 20),
                  filled: true),
              controller: employeeIDTextEditingController,
            ),
            SizedBox(height: 60.0),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 50,
                  disabledColor: Colors.blueAccent,
                  child: ElevatedButton(
                    //disabledElevation: 4.0,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/LoginOTP");
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
    );
  }
}
