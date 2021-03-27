import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:http/http.dart' as http;
import 'package:shepherd/location/LocationFinder.dart';
import 'package:shepherd/provider/GlobalState.dart';

class ClockController
{
  static Future<void> clockIn(BuildContext context) async
  {
    final globalState = Provider.of<GlobalState>(context, listen:false);
    if (globalState.clientIDController.text.characters.length != 6 ||
        globalState.clockInPassController.text.characters.length != 6)
    {
      final snackBar = SnackBar(
        content: Row(
          children: [
            Text('Invalid Client ID or Password',
              style: TextStyle(color: Colors.red, fontSize: 20)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    };

    LocationFinder locFinder = new LocationFinder();
    await locFinder.getLocation();

    await showProgressIndicator(context);

    SnackBar snackBar;

    WorkData workData = new WorkData(
      isClockIn: true,
      userId: int.parse(globalState.userId),
      clientId: int.parse(globalState.clientIDController.text),
      clientPass: int.parse(globalState.clockInPassController.text),
      time: locFinder.locationData.time,
      latitude: locFinder.locationData.latitude,
      longitude: locFinder.locationData.longitude
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
    Navigator.of(context).pop();

  }

  static Future<void> clockOut(BuildContext context) async
  {
    final globalState = Provider.of<GlobalState>(context, listen:false);
    if (globalState.clockOutPassController.text.characters.length != 6)
    {
      final snackBar = SnackBar(
        content: Row(
          children: [
            Text('Invalid Client ID or Password',
              style: TextStyle(color: Colors.red, fontSize: 20)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    };

    LocationFinder locFinder = new LocationFinder();
    await locFinder.getLocation();

    await showProgressIndicator(context);

    SnackBar snackBar;

    WorkData workData = new WorkData(
      isAuthenticated: false,
      isClockIn: true,
      userId: int.parse(globalState.userId),
      clientId: int.parse(globalState.clientIDController.text),
      clientPass: int.parse(globalState.clockInPassController.text),
      time: locFinder.locationData.time,
      latitude: locFinder.locationData.latitude,
      longitude: locFinder.locationData.longitude
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
            Text('Clock Out: ',
              style: TextStyle(color: Colors.white, fontSize: 24)),
            Text('SUCCESS',
              style: TextStyle(color: Colors.green, fontSize: 24)),
          ],
        )
      );

      workData.isAuthenticated = true;
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
    globalState.localdbContainer.insert(workData);
      
    Navigator.of(context).pop();
    Navigator.of(context).pop();

  }

  // This is really bad.  
  // https://stackoverflow.com/questions/53836876/is-it-possible-to-disable-shadow-overlay-on-dialog
  static void showProgressIndicator(BuildContext context)
  {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (context) {
            return Material(
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 200.0,
                        width: 250.0,
                        color: Colors.transparent,
                        child:
                            Column(
                              children: [
                                Center(child: CircularProgressIndicator()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Waiting for verification from server.",
                                    style: TextStyle(color: Colors.white, fontSize: 12)
                                  ),
                                )
                              ],
                            ))));
          }),
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Color(0xAA000000),
      transitionDuration: const Duration(milliseconds: 150)
    );
  }

}