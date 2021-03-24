import 'package:flutter/material.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/location/LocationFinder.dart';

class GlobalState extends ChangeNotifier
{
  // Domain data
  bool isClockedIn;
  String clientId;
  LocationFinder locationFinder;
  LocalDBContainer localdbContainer;

  // UI data
  int numTasks = 1;
  List<TextEditingController> taskController = [];
  var clockButtonRoute = '/ClockIn';
  var clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));

  // Used to grab data from TextField objects.
  final clientIDController = TextEditingController();
  final clientPassController = TextEditingController();
  

  GlobalState(this.locationFinder, this.localdbContainer)
  {
    // Query database.  If every entry isAuthenticated, set isClockedIn = false
    // Otherwise, grab the entry with the newest timestamp, check its 
    // isClockedIn value, and set GlobalState's isClockedIn accordingly. 
  }

  // These notifying functions should only be responsbile for UI changes.  We 
  // will have a separate controller with clockIn() and clockOut() that 
  // perform business logic.
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