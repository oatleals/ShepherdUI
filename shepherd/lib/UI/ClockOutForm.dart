import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/controllers/ClockController.dart';
import 'package:shepherd/errors.dart';

import 'common.dart';


class ClockOutForm extends StatefulWidget {
  ClockOutForm({Key key}) : super(key: key);

  @override
  _ClockOutFormState createState() => _ClockOutFormState();
}

class _ClockOutFormState extends State<ClockOutForm> {
  @override
  Widget build(BuildContext context) 
  {
    final tokenTextController = new TextEditingController();
    final prefs = SharedPreferences.getInstance();

    return FutureBuilder(
      future: prefs,
      builder: (context, snapshot)
      {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Client ID: ", style: TextStyle(fontSize: 20, color: Colors.white)),
                            Text( snapshot.connectionState == ConnectionState.done ?
                              snapshot.data.getInt('clientId').toString() :
                              '', 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue
                              )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Office ID: ", style: TextStyle(fontSize: 20, color: Colors.white)),
                            Text( snapshot.connectionState == ConnectionState.done ?
                              snapshot.data.getInt('officeId').toString() :
                              '', 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      onPressed:() { Navigator.of(context).pop(); }, 
                      icon: Icon(Icons.close)
                    ),
                  ],
                ),
               
                Row(
                  children: [
                    Container(
                      width: 175,
                      child: TextField(
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                        controller: tokenTextController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 2)),
                            labelText: 'Token'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt, size: 35, color: Colors.blue),
                      onPressed: (){}, // OpenScanner()
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 8),
                  child: MultiSelectFormField(
                    checkBoxActiveColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    dialogTextStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    chipBackGroundColor: Colors.blue,
                    chipLabelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    checkBoxCheckColor: Colors.blue,
                    fillColor: Colors.blue[200],
                    title: Text('Tasks', style: TextStyle(color: Colors.white, fontSize: 24),),
                    hintWidget: null,
                    autovalidate: false,
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                    },
                    dataSource: [
                      {
                        "display": "task1",
                        "value": "task1",
                      },
                      {
                        "display": "task2",
                        "value": "task2",
                      },
                      {
                        "display": "task3",
                        "value": "task3",
                      },
                      {
                        "display": "task4",
                        "value": "task4",
                      },
                      {
                        "display": "task5",
                        "value": "task5",
                      },
                      {
                        "display": "task6",
                        "value": "task6",
                      }
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                  ),
                )
                
              ],
            ),
            ElevatedButton(
              onPressed: () async
              {
                showProgressIndicatorDialog(context);
                var token;

                try {
                  token = int.parse(tokenTextController.text);
                }
                catch(_) {
                  token = -1;
                  print('passing bad values to clock() to generate invalid input response within ui');
                }

                final prefs = await SharedPreferences.getInstance();
                
                final status = await clock(
                  false, // is clock out
                  prefs.getInt('clientId'),
                  token,
                  prefs.getInt('officeId'));

                Navigator.of(context).pop(); // pop progress indicator
                showSnackbar(status);
              },

              child: Container(
                // This is how to get the maximum width of the display.
                width: MediaQuery.of(context).size.width - 150,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Clock Out", style: TextStyle(fontSize: 40)),
                  ),
                )
              )
            ),
          ],
        );
      }
    );
  }

  void showSnackbar(ERROR status) 
  {
    switch (status)
    {
      case ERROR.success:
        final snackBar = SnackBar(
          content: Row(
            children: [
              Text('Clock Out: ',
                style: TextStyle(color: Colors.white, fontSize: 20)),
              Text('SUCCESS',
                style: TextStyle(color: Colors.green, fontSize: 20)),
            ],
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        while (Navigator.of(context).canPop()) 
          Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/Home');
        break;

      case ERROR.http_failed:
        final snackBar = SnackBar(
          content: Row(
            children: [
              Text('Clock Out: ',
                style: TextStyle(color: Colors.white, fontSize: 20)),
              Text('SUCCESS (UNVERIFIED)',
                style: TextStyle(color: Colors.yellow, fontSize: 20)),
            ],
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        while (Navigator.of(context).canPop()) 
          Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/Home');
        break;

      case ERROR.no_connection:
        final snackBar = SnackBar(
          content: Row(
            children: [
              Text('Clock Out: ',
                style: TextStyle(color: Colors.white, fontSize: 20)),
              Text('SUCCESS (UNVERIFIED)',
                style: TextStyle(color: Colors.yellow, fontSize: 20)),
            ],
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        while (Navigator.of(context).canPop()) 
          Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/Home');
        break;

      case ERROR.invalid_input:
        final snackBar = SnackBar(
          content: Text('INVALID INPUT',
            style: TextStyle(color: Colors.red, fontSize: 20)));
        FocusScope.of(context).unfocus(); // hide keyboard
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
    }
  }
}
