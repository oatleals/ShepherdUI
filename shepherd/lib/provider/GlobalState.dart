import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shepherd/location/LocationFinder.dart';

class GlobalState extends ChangeNotifier
{
  String clientId;

  var clockButtonRoute = '/ClockIn';
  var clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));

  // Used to grab data from TextField objects.
  final clientIDController = TextEditingController();

  // Used to grab GPS data.
  LocationData locationData;


  GlobalState(LocationData locData)
  {
    locationData = locData;
  }

  void setConnected(bool val)
  {
    notifyListeners();
  }

  void clockIn()
  {
    clockButtonRoute = '/ClockOut';
    clockButtonText = Text("Clock Out", style: TextStyle(fontSize: 50));
    notifyListeners();
  }

  void clockOut()
  {
    clockButtonRoute = '/ClockIn';
    clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));
    notifyListeners();
  }

  void setClientId(String id)
  {
    clientId = id;
    notifyListeners();
  }

}