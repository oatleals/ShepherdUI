import 'package:flutter/material.dart';
import 'package:shepherd/location/LocationFinder.dart';

class GlobalState extends ChangeNotifier
{
  String clientId;

  int numTasks = 1;

  List<TextEditingController> taskController = [];

  // These are used to switch the button between "Clock In" and "Clock Out".
  // The initial values are clock in because we're assuming the user
  // is not clocked in when launching the app.
  var clockButtonRoute = '/ClockIn';
  var clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));

  // Used to grab data from TextField objects.
  final clientIDController = TextEditingController();

  // Used to grab GPS data.
  LocationFinder locationFinder;

  // This is a constructor that initializes this.locationFinder with the 
  // 1 argument passed.
  GlobalState(this.locationFinder);

  void clockIn({String clientId})
  {
    this.clientId = clientId;
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

  void newTask() 
  {
    numTasks++;
    notifyListeners();
  }

}