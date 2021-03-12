import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

class ClockOutForm extends StatefulWidget 
{
  ClockOutForm({Key key}) : super(key: key);

  @override
  _ClockOutFormState createState() => _ClockOutFormState();
}
class _ClockOutFormState extends State<ClockOutForm> 
{
  @override
  Widget build(BuildContext context) 
  {
    GlobalState globalState = Provider.of<GlobalState>(context, listen:false);
    String clientID = globalState.clientId;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 6,top: 8.0),
          child: Row(
            children: [
              Text("Client ID:", 
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                )
              ),
              Text("$clientID", 
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue
                )
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
                style: TextStyle(
                  fontSize:35,
                  color: Colors.blue
                ),
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  labelText: 'Password'
                ),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, size: 35, color: Colors.blue),
                onPressed: (){}, // OpenScanner()
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () { 
            globalState.clockOut();
            Navigator.of(context).pop();
          },
          child: Container(
            // This is how to get the maximum width of the display.
            width: MediaQuery.of(context).size.width - 150,
            child: Center(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Clock Out", style: TextStyle(fontSize: 40)),
                ),
              )
            )
          )
        ),
      ],
    );
  }

}