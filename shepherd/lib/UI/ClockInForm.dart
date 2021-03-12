import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';


class ClockInForm extends StatefulWidget 
{
  ClockInForm({Key key}) : super(key: key);

  @override
  _ClockInFormState createState() => _ClockInFormState();
}
class _ClockInFormState extends State<ClockInForm> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            style: TextStyle(
              fontSize:35,
              color: Colors.blue
            ),
            controller: Provider.of<GlobalState>(context).clientIDController,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),              
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
                style: TextStyle(
                  fontSize:35,
                  color: Colors.blue
                ),
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,//this has no effect
                    ),
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
                child: Text("Clock In", style: TextStyle(fontSize: 40)),
              ),)
            )
          )
        ),
      ],
    );
  }

}