import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

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
                  Text(
                    " " + Provider.of<GlobalState>(context).myController.text, 
                    style: TextStyle(fontSize: 35)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom:8.0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Client Password'
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: (){}, // OpenScanner()
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () { 
                var globalState = Provider.of<GlobalState>(context, listen:false);
                globalState.clockOut();
                Navigator.of(context).pop();
              },
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