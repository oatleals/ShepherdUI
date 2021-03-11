import 'package:flutter/material.dart';

import 'UI/HomePage.dart';
import 'UI/ClockInPage.dart';
import 'UI/ClockOutPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Home': (context) => HomePage(),
        '/ClockIn': (context) => ClockInPage(),
        '/ClockOut': (context) => ClockOutPage(),
      },
      title: 'Shepherd EVV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}