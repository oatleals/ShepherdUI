import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key key}) : super(key: key);

  @override
  _ClockInPageState createState() => _ClockInPageState();
}
class _ClockInPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMPLOYEE ID: ',
                    ),
                    Text(
                      'DEVICE LOCATION: ',
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client id'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom:8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client password'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){}, // This is where we call Clock() from Controller. 
              child: Container(
                // This is how to get the maximum width of the display.
                width: MediaQuery.of(context).size.width - 75,
                child: Center(
                  child: Text("Clock in")
                )
              )
            ),
            
          ],
        ),
      ),
    );
  }
}