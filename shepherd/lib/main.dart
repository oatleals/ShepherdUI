import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

import 'UI/HomePage.dart';
import 'UI/ClockInForm.dart';
import 'UI/ClockOutForm.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Home': (context) => HomePage(),
        '/ClockIn': (context) => ClockInForm(),
        '/ClockOut': (context) => ClockOutForm(),
      },
      title: 'Shepherd EVV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        hintColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}