import 'package:flutter/material.dart';
import 'package:shepherd/controllers/ClockController.dart';

import '../errors.dart';
import 'common.dart';


class ClockInForm extends StatefulWidget 
{
  ClockInForm({Key key}) : super(key: key);

  @override
  _ClockInFormState createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  @override
  Widget build(BuildContext context) 
  {
    final clientIdTextController = new TextEditingController();
    final officeIdTextController = new TextEditingController();
    final tokenTextController = new TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: TextField(
                style: TextStyle(fontSize: 35, color: Colors.blue),
                controller: clientIdTextController,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    labelText: 'Client ID'),
              ),
            ),
            IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0, bottom:8.0),
          child: TextField(
            style: TextStyle(
              fontSize:35,
              color: Colors.blue
            ),
            controller: officeIdTextController,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
                ),
              ),              
              labelText: 'Office ID'
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:8.0, bottom:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 175,
                child: TextField(
                  style: TextStyle(fontSize: 35, color: Colors.blue),
                  controller: tokenTextController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      labelText: 'Token'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, size: 30, color: Colors.blue),
                onPressed: () {}, // For scanning token.
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async
          { 
            showProgressIndicatorAlertDialog(context);
            var clientId;
            var token;
            var officeId;

            try {
              clientId = int.parse(clientIdTextController.text);
              token = int.parse(tokenTextController.text);
              officeId = int.parse(officeIdTextController.text);
            }
            catch(_) {
              clientId = -1;
              token = -1;
              officeId = -1;
              print('passing bad values to clock() to generate invalid input response within ui');
            }
            
            final status = await clock(
              true, // is clock in
              clientId,
              token,
              officeId
            );

            Navigator.of(context).pop(); // pop progress indicator
            showSnackbar(context, status);
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

