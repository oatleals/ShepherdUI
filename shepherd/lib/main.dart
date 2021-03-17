import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/location/LocationFinder.dart';
import 'package:shepherd/provider/GlobalState.dart';

import 'UI/HomePage.dart';
import 'UI/ClockInForm.dart';
import 'UI/ClockOutForm.dart';


main() async 
{
  WidgetsFlutterBinding.ensureInitialized();
  
  LocationFinder locationFinder = new LocationFinder();
  // We need to wait for the locationFinder to pull data before we run the app
  // because the HomePage uses locationData in its build().
  // ignore: await_only_futures
  await locationFinder.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(locationFinder),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      routes: 
      {
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