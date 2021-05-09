import 'package:shepherd/connectivity/ConnectionChecker.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:shepherd/location/LocationFinder.dart';
import 'package:shepherd/errors.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockController
{
  static Future<ERROR> clock({
    @required bool clockin,
    @required int clientId, 
    @required int token}) async
  {
    if (clientId.toString().length != 6 || token.toString().length != 6)
      return ERROR.invalid_input;

    var postSuccess = false;
    final connection = new ConnectionChecker();
    final sharedPreferences = await SharedPreferences.getInstance();

    final localDBContainer = new LocalDBContainer();
    await localDBContainer.init();

    final locationFinder = new LocationFinder();
    await locationFinder.getLocation();
    
    WorkData workData = new WorkData(
      isClockIn: clockin,
      userId: sharedPreferences.getInt('userId'),
      clientId: clientId,
      token: token,
      time: locationFinder.locationData.time,
      latitude: locationFinder.locationData.latitude,
      longitude: locationFinder.locationData.longitude
    );

    if (await connection.isConnected())
    {
      final url = clockin ? 
        Uri.parse('https://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-in'):
        Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-out');
      final client = Client();
      final response = await client.post(url, body: workData.serializeForEVV());
      client.close();

      postSuccess = response.statusCode == 200;
    }

    sharedPreferences.setBool('isClockedIn', true);
    localDBContainer.insert(workData);

    return postSuccess ? 
      ERROR.success :
      ERROR.http_failed;
  }

  static Future<void> clockOut({int clientId, int token}) async
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
    }

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

    final url = Uri.parse('EmployeeInfo server endpoint'); 
    var dataAuthenticated = true;

    ConnectionChecker connection = new ConnectionChecker();
    bool connected = await connection.isConnected();

    if (connected)
    {
      var response;

      try 
      {
        final client = Client();
        await client.post(url, body: workData.serializeForEVV()); 
        response = await client.get(url);
        client.close();
      }
      catch (any)
      {
        dataAuthenticated = false;
      }
      
      dataAuthenticated = dataAuthenticated && response.body == "AUTHENTICATED"; // placeholder
    }
    else 
    {
      dataAuthenticated = false;
    }


    if (dataAuthenticated)
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