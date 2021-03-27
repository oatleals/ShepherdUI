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
    var globalState = Provider.of<GlobalState>(context, listen: false);
    String userId = globalState.userId;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("User ID: $userId  ", style: TextStyle(fontSize: 15)),
            Text("GPS:  ", style: TextStyle(fontSize: 15)),
            Text(
              globalState.locationFinder.locationData.latitude.toString(),
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
              globalState.locationFinder.locationData.longitude.toString(),
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
                    onPressed: () 
                    { 
                      if (globalState.isClockedIn)
                        showClockOutDialog(context);
                      else 
                        showClockInDialog(context); 
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
