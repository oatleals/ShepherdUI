import 'package:flutter/material.dart';
import 'package:shepherd/location/LocationFinder.dart';

class GlobalState extends ChangeNotifier
{
  LocationFinder locationFinder = new LocationFinder(); 

  String clientId;
  var clockRoute = '/ClockIn';
  var buttonText = Text("Clock In", style: TextStyle(fontSize: 50));
  final clientIDController = TextEditingController();


  GlobalState(){
    locationFinder.init();
  }

  void setConnected(bool val)
  {
    notifyListeners();
  }

  void clockIn()
  {
    clockRoute = '/ClockOut';
    buttonText = Text("Clock Out", style: TextStyle(fontSize: 50));
    notifyListeners();
  }

  void clockOut()
  {
    clockRoute = '/ClockIn';
    buttonText = Text("Clock In", style: TextStyle(fontSize: 50));
    notifyListeners();
  }

  void setClientId(String id)
  {
    clientId = id;
    notifyListeners();
  }

}