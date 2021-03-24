import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/provider/GlobalState.dart';

class data {
  int clientID = 0000;
  String password = "";
}

class ClockInForm extends StatefulWidget {
  ClockInForm({Key key}) : super(key: key);

  @override
  _ClockInFormState createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  @override
  Widget build(BuildContext context) {
    // Grab reference of clientIdController from GlobalState so that we can
    // connect it to the TextField where the user enters the Client ID.  This
    // way, we can can reference the controller outside of this scope and get
    // the Client ID value anywhere in the project.
    GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
    TextEditingController textFieldController = globalState.clientIDController;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            style: TextStyle(fontSize: 35, color: Colors.blue),
            controller: textFieldController,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                labelText: 'Client ID'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Container(
                width: 215,
                child: TextField(
                  style: TextStyle(fontSize: 35, color: Colors.blue),
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      labelText: 'Password'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, size: 35, color: Colors.blue),
                onPressed: () {}, // For scanning password.
              )
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              final snackBar = SnackBar(
                  content: Row(
                children: [
                  Text('Clock In: ',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  Text('SUCCESS',
                      style: TextStyle(color: Colors.green, fontSize: 24)),
                ],
              ));

              globalState.clockIn(clientId: textFieldController.text);

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.of(context).pop();
            },
            child: Container(
                // This is how to get the maximum width of the display.
                width: MediaQuery.of(context).size.width - 150,
                child: Center(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clock In", style: TextStyle(fontSize: 40)),
                  ),
                )))),
      ],
    );
  }
}
