import 'package:flutter/material.dart';

class ClockOutPage extends StatefulWidget {
  ClockOutPage({Key key}) : super(key: key);

  @override
  _ClockOutPageState createState() => _ClockOutPageState();
}
class _ClockOutPageState extends State<ClockOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User ID: 123456"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 6,top: 8.0),
              child: Row(
                children: [
                  Text("Client ID:", style: TextStyle(fontSize: 25)),
                  Text(" 456789", style: TextStyle(fontSize: 30)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom:8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client Password'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){}, // This is where we call Clock() from Controller. 
              child: Container(
                // This is how to get the maximum width of the display.
                width: MediaQuery.of(context).size.width - 150,
                child: Center(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clock Out", style: TextStyle(fontSize: 30)),
                  ),)
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}