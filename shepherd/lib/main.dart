import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/HistoryPage.dart';
import 'UI/HomePage.dart';
import 'UI/LoginPage.dart';
import 'UI/LoginPageOTP.dart';

main() async 
{ 
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPrefs();

  runApp(ShepherdApp());
}

class ShepherdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Home': (context) => HomePage(),
        '/ViewHistory': (context) => HistoryPage(),
        '/Login': (context) => LoginPage(),
        '/LoginOTP': (context) => LoginPageOTP(),
      },
      title: 'Shepherd EVV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        hintColor: Colors.white,
      ),
      home: LoginPage(),
    );
  }
}

Future<void> initializeSharedPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('userId', 1);

  try {
    prefs.getBool('isClockedIn');
  }
  catch (_) {
    prefs.setBool('isClockedIn', false);
  }

  prefs.setBool('isClockedIn', false);
}