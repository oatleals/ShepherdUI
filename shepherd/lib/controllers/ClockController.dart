import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:http/http.dart' as http;
import 'package:shepherd/provider/GlobalState.dart';


class ClockController
{
  static Future<void> clockIn(BuildContext context) async
  {
    final globalState = Provider.of<GlobalState>(context, listen:false);
    globalState.localdbContainer;
    await globalState.locationFinder.init();

    SnackBar snackBar;

    WorkData workData = new WorkData(
      isClockIn: true,
      userId: int.parse(globalState.userId),
      clientId: int.parse(globalState.clientIDController.text),
      clientPass: int.parse(globalState.clientPassController.text),
      time: globalState.locationFinder.locationData.time,
      latitude: globalState.locationFinder.locationData.latitude,
      longitude: globalState.locationFinder.locationData.longitude
    );

    var url = Uri.parse('https://path/to/backend'); 
    var response;
    bool data_authenticated = true;
    try 
    {
      response = await http.post(url, body: workData.stringStringMap()); 
    }
    catch (any)
    {
      data_authenticated = false;
    }

    data_authenticated = data_authenticated && response.body == "AUTHENTICATED"; // placeholder

    if (data_authenticated)
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock In: ',
              style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('SUCCESS',
              style: TextStyle(color: Colors.green, fontSize: 24)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock In: ',
              style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('NOT VERIFIED',
              style: TextStyle(color: Colors.yellow, fontSize: 24)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    globalState.clockIn(clientId: globalState.clientIDController.text);
    globalState.localdbContainer.insert(workData);
      
    Navigator.of(context).pop();
  }

  static Future<void> clockOut(BuildContext context) async
  {
    GlobalState globalState = Provider.of<GlobalState>(context, listen:false);
    LocalDBContainer localdbContainer = globalState.localdbContainer;
    SnackBar snackBar;

    List<String> tasks;
    for (TextEditingController controller in globalState.taskControllers)
    {
      tasks.add(controller.text);
    }

    WorkData workData = new WorkData(
      isAuthenticated: false,
      isClockIn: false,
      userId: int.parse(globalState.userId),
      clientId: int.parse(globalState.clientIDController.text),
      clientPass: int.parse(globalState.clientPassController.text),
      time: globalState.locationFinder.locationData.time,
      latitude: globalState.locationFinder.locationData.latitude,
      longitude: globalState.locationFinder.locationData.longitude,
      tasks: tasks
    );

    var url = Uri.parse('http://path/to/backend'); 
    var response = await http.post(url, body: workData.stringStringMap());

    bool data_authenticated = response.body == "AUTHENTICATED"; // placeholder

    if (data_authenticated)
    {
      workData.isAuthenticated = true;
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock Out: ',
              style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('SUCCESS',
              style: TextStyle(color: Colors.green, fontSize: 24)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock Out: ',
              style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('NOT VERIFIED',
              style: TextStyle(color: Colors.yellow, fontSize: 24)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    globalState.clockOut();
    localdbContainer.insert(workData);
      
    Navigator.of(context).pop();
  }
}