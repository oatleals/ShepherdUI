import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/connectivity/ConnectionChecker.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:http/http.dart' as http;
import 'package:shepherd/location/LocationFinder.dart';

class ClockController
{
  static Future<void> clockIn({
    BuildContext context, 
    int clientId, 
    int token}) async
  {
    final localDBContainer = new LocalDBContainer();
    await localDBContainer.init();
    final prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getInt('clientId').toString();
    final token = prefs.getInt('token').toString();

    ConnectionChecker connection = new ConnectionChecker();

    if (clientId.length != 6 || token.length != 6)
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


    WorkData workData = new WorkData(
      isClockIn: 1,
      userId: prefs.getInt('userId'),
      clientId: prefs.getInt('clientId'),
      token: prefs.getInt('token'),
      time: locFinder.locationData.time,
      latitude: locFinder.locationData.latitude,
      longitude: locFinder.locationData.longitude
    );

    bool connected = await connection.isConnected();

    var url = Uri.parse('https://path/to/backend'); 
    bool data_authenticated = true;

    SnackBar snackBar;

    if (connected)
    {
      Response auth;

      try 
      {
        var client = http.Client();
        await client.post(url, body: workData.stringStringMap()); 
        auth = await client.get(url);
        client.close();
      }
      catch (any)
      {
        data_authenticated = false;
      }

      data_authenticated = data_authenticated && auth.body == "AUTHENTICATED"; // placeholder

    }
    else 
    {
      data_authenticated = false;
    }


    if (data_authenticated && connected)
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock In: ',
              style: TextStyle(color: Colors.white, fontSize: 20)),
            Text('SUCCESS',
              style: TextStyle(color: Colors.green, fontSize: 20)),
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
              style: TextStyle(color: Colors.white, fontSize: 20)),
            Text('SUCCESS (UNVERIFIED)',
              style: TextStyle(color: Colors.yellow, fontSize: 20)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    prefs.setBool('isClockedIn', true);
    localDBContainer.insert(workData);
      
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/Home');

  }

  static Future<void> clockOut(BuildContext context) async
  {
    final localDBContainer = new LocalDBContainer();
    await localDBContainer.init();
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getInt('token').toString();

    if (token.length != 6)
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
      isAuthenticated: 0,
      isClockIn: 1,
      userId: prefs.getInt('userId'),
      clientId: prefs.getInt('clientId'),
      token: prefs.getInt('token'),
      time: locFinder.locationData.time,
      latitude: locFinder.locationData.latitude,
      longitude: locFinder.locationData.longitude
    );

    var url = Uri.parse('https://path/to/backend'); 
    bool data_authenticated = true;

    ConnectionChecker connection = new ConnectionChecker();
    bool connected = await connection.isConnected();

    if (connected)
    {
      Response auth;

      try 
      {
        var client = http.Client();
        await client.post(url, body: workData.stringStringMap()); 
        auth = await client.get(url);
        client.close();
      }
      catch (any)
      {
        data_authenticated = false;
      }
      
      data_authenticated = data_authenticated && auth.body == "AUTHENTICATED"; // placeholder
    }
    else 
    {
      data_authenticated = false;
    }


    if (data_authenticated)
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock Out: ',
              style: TextStyle(color: Colors.white, fontSize: 20)),
            Text('SUCCESS',
              style: TextStyle(color: Colors.green, fontSize: 20)),
          ],
        )
      );

      workData.isAuthenticated = 1;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else
    {
      snackBar = SnackBar(
        content: Row(
          children: [
            Text('Clock Out: ',
              style: TextStyle(color: Colors.white, fontSize: 20)),
            Text('SUCCESS (UNVERIFIED)',
              style: TextStyle(color: Colors.yellow, fontSize: 20)),
          ],
        )
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // Clear out prefs.  Do we need this?
    prefs.setInt('clientId', 0);
    prefs.setInt('token', 0);
    
    prefs.setBool('isClockedIn', false);
    localDBContainer.insert(workData);
  
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/Home');

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