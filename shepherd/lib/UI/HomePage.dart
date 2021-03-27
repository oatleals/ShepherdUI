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
    var globalState = Provider.of<GlobalState>(context);
    String userId = globalState.userId;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left:8.0, right:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Joe Smith  ", style: TextStyle(fontSize: 15)),
              Text("ID: $userId  ", style: TextStyle(fontSize: 15)),
              
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
