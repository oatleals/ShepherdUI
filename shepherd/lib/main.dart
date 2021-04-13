import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/HomePage.dart';



main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeSharedPrefs();

  runApp(MyApp());
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
      },
      title: 'Shepherd EVV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        hintColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
  
}

Future<void> initializeSharedPrefs() async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('userId', 1);

  if (prefs.getBool('isClockedIn') == null)
  {
    prefs.setBool('isClockedIn', false);
  }
}