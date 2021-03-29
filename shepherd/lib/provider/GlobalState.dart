import 'package:flutter/material.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';

class GlobalState extends ChangeNotifier
{
  // Domain data
  bool isClockedIn;
  String clientId;
  String userId;
  LocalDBContainer localdbContainer;

  // UI data
  int numTasks = 1;
  List<TextEditingController> taskControllers = [];
  var clockButtonRoute = '/ClockIn';
  var clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));

  // Used to grab data from TextField objects.
  final clientIDController = TextEditingController();
  final clockInPassController = TextEditingController();
  final clockOutPassController = TextEditingController();
  

  GlobalState(this.localdbContainer)
  {
    userId = '000000';

    isClockedIn = false;

    // Query database, grab the entry with the newest timestamp, check its 
    // isClockedIn value, and set GlobalState's isClockedIn accordingly. 
  }

  // These notifying functions should only be responsbile for UI changes.  We 
  // will have a separate controller with clockIn() and clockOut() that 
  // perform business logic.
  void clockIn({String clientId})
  {
    isClockedIn = true;
    this.clientId = clientId;
    clockButtonRoute = '/ClockOut';
    clockButtonText = Text("Clock Out", style: TextStyle(fontSize: 50));
    notifyListeners();
  }

  void clockOut()
  {
    isClockedIn = false;
    clockButtonRoute = '/ClockIn';
    clockButtonText = Text("Clock In", style: TextStyle(fontSize: 50));

    clientIDController.clear();
    clockInPassController.clear();
    clockOutPassController.clear();
    // TODO: clear task controllers
    
    notifyListeners();
  }

  void newTask() 
  {
    numTasks++;
    notifyListeners();
  }

}