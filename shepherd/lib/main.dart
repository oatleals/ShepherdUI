import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

import 'UI/HomePage.dart';
import 'UI/ClockInForm.dart';
import 'UI/ClockOutForm.dart';
import 'location/LocationFinder.dart';


main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();


  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(_locationData),
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