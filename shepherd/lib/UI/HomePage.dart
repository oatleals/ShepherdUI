import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/UI/common.dart';

import 'ClockInForm.dart';
import 'ClockOutForm.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final userId = snapshot.data.getInt('userId').toString();
      
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left:8.0, right:8.0),
                child: snapshot.data.getBool('isClockedIn') ?
                  Row(
                    children: [ 
                      Text('Forgot to clock out?'), 
                      IconButton(
                        onPressed: () {
                          snapshot.data.setBool('isClockedIn', false);
                          Navigator.of(context).pushReplacementNamed('/Home');
                        },
                        icon: Icon(Icons.assignment_return_outlined))
                    ]
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Joe Smith  ", style: TextStyle(fontSize: 15)),
                      Text("ID: $userId  ", style: TextStyle(fontSize: 15)),
                    ],
                  )
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
                        if (snapshot.data.getBool('isClockedIn'))
                          showClockOutForm(context);
                        else 
                          showClockInForm(context); 
                      }, 
                      child: Container(
                        child: Center(
                          child: Text(
                            snapshot.data.getBool('isClockedIn')? 
                              'Clock out' : 'Clock in', 
                            style: TextStyle(fontSize: 50)
                          )
                        )
                      )
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(),
                            primary: Colors.blue[200]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/ViewHistory');
                        },
                        child: Container(
                            child: Center(
                          child: Text("View History",
                              style: TextStyle(fontSize: 50)),
                        ))),
                  ),
                ],
              ),
            ),
          );
        }
        else
        {
          return Scaffold(

          );
          showProgressIndicatorAlertDialog(context);
        }
      }
    );
  }

  void showClockInForm(BuildContext context) 
  {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.white, width: 3)
            ),
            backgroundColor: Colors.blue[200],
            content: SingleChildScrollView(
              //height: 300, 
              child: ClockInForm()
            )
          ),
        );
      }
    ); 
  }
  
  void showClockOutForm(BuildContext context) 
  {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.white, width: 3)
            ),
            backgroundColor: Colors.blue[200],
            content: SingleChildScrollView(
              //height: MediaQuery.of(context).size.height - 200, 
              child: ClockOutForm()
            )
          )
        );
      }
    ); 
  }
  
}
