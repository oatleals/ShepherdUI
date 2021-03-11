import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ID: 123456"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  primary: Colors.blue[400],
                ),
                onPressed: (){ Navigator.pushNamed(context, '/ClockIn'); }, 
                child: Container(
                  child: Center(child: Text("Clock In", style: TextStyle(fontSize: 50)),)
                )
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(),
                  primary: Colors.blue[300],
                ),
                onPressed: (){ Navigator.pushNamed(context, '/ClockOut'); }, 
                child: Container(
                  child: Center(child: Text("Clock Out", style: TextStyle(fontSize: 50)),)
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
                  child: Center(child: Text("View History", style: TextStyle(fontSize: 50)),)
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
