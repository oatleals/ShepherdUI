import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

class ClockInPage extends StatefulWidget {
  ClockInPage({Key key}) : super(key: key);

  @override
  _ClockInPageState createState() => _ClockInPageState();
}
class _ClockInPageState extends State<ClockInPage> {
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
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Client ID'
                ),
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
                globalState.clockIn();
                Navigator.of(context).pop();
              },  
              child: Container(
                // This is how to get the maximum width of the display.
                width: MediaQuery.of(context).size.width - 150,
                child: Center(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clock In", style: TextStyle(fontSize: 30)),
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