import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

import 'ClockInForm.dart';
import 'ClockOutForm.dart';

class HomePage extends StatefulWidget 
{
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  @override
  Widget build(BuildContext context) 
  {
    // Grab data from GlobalState.
    bool clockedOut = 
      Provider.of<GlobalState>(context, listen: false)
        .clockButtonRoute == '/ClockIn';
    
    String latitude = 
      Provider.of<GlobalState>(context)
        .locationFinder.locationData.latitude.toString();
    
    String longitude = 
      Provider.of<GlobalState>(context)
        .locationFinder.locationData.longitude.toString();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("User ID: 123456   ", style: TextStyle(fontSize: 15)),
            Text("GPS:  ", style: TextStyle(fontSize: 15)),
            Text(
              latitude,
              style: TextStyle(
                fontSize: 13
              )
            ),
            Text(", ",
              style: TextStyle(
                fontSize: 13
              )
            ),
            Text(
              longitude,
              style: TextStyle(
                fontSize: 13
              )
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<GlobalState>(
              builder: (context, globalState, child) => 
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(),
                      primary: Colors.blue[300],
                    ),
                    onPressed: () { 
                      if (clockedOut)
                        showClockInDialog(context); 
                      else 
                        showClockOutDialog(context);
                    }, 
                    child: Container(
                      child: Center(child: globalState.clockButtonText)
                    )
                  ),
                ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  primary: Colors.blue[200]
                ),
                onPressed: (){ Navigator.pushNamed(context, '/ViewHistory'); }, 
                child: Container(
                  child: Center(
                    child: Text("View History", style: TextStyle(fontSize: 50)),
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showClockInDialog(BuildContext context) 
  {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white)
          ),
          backgroundColor: Colors.blue[200],
          content: Container(
            height: 300, 
            child: ClockInForm()
          )
        );
      }
    );
  }
  
  void showClockOutDialog(BuildContext context) 
  {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white)
          ),
          backgroundColor: Colors.blue[200],
          content: Container(
            height: 300, 
            child: ClockOutForm()
          )
        );
      }
    );
  }

}
