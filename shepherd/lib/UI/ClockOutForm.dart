import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/controllers/ClockController.dart';
import 'package:shepherd/errors.dart';


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
    final tokenTextController = new TextEditingController();
    final prefs = SharedPreferences.getInstance();

    return FutureBuilder(
      future: prefs,
      builder: (context, snapshot)
      {
        if (snapshot.connectionState == ConnectionState.done)
        {
          var taskEnabled = [false,false,false,false,false];
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Text("Client ID: ", style: TextStyle(fontSize: 20, color: Colors.white)),
                            Text(snapshot.data.getInt('clientId').toString(), 
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue
                              )
                            ),
                          ],
                        ),
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
                          style: TextStyle(
                            fontSize:20,
                            color: Colors.blue
                          ),
                          controller: tokenTextController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2
                              )
                            ),
                            labelText: 'Token'
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, size: 35, color: Colors.blue),
                        onPressed: (){}, // OpenScanner()
                      )
                    ],
                  ),
                  Container(
                    height:250,
                    width:200,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index)
                      {
                        return StatefulBuilder(
                          builder: (context, setState)
                          {
                            return CheckboxListTile(
                              checkColor: Colors.white,
                              title: Text('task',
                                style: TextStyle(color: Colors.white),),
                              value: taskEnabled[index], 
                              onChanged: (bool val) async
                              {            
                                setState(() {
                                  taskEnabled[index] = val;
                                });              
                              }
                            );
                          }
                        );
                      })
                        
                  ),
                  
                ],
              ),
              ElevatedButton(
                onPressed: () async
                {
                  final prefs = await SharedPreferences.getInstance();
                  
                  final status = await clock(
                    false, // is clock out
                    prefs.getInt('clientId'),
                    int.parse(tokenTextController.text));

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
        else
        {
          return SafeArea(
            child: Builder(builder: (context) {
              return Material(
                  color: Colors.transparent,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 200.0,
                        width: 250.0,
                        color: Colors.transparent,
                        child: Column(
                              children: [
                                Center(child: CircularProgressIndicator()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Waiting for verification from server.",
                                    style: TextStyle(color: Colors.white, fontSize: 12)
                                  ),
                                )
                              ],
                            )
                          )));
            }),
          );
        }
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
        Navigator.of(context).popUntil(ModalRoute.withName('/Home'));
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
        Navigator.of(context).popUntil(ModalRoute.withName('/Home'));
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
        Navigator.of(context).popUntil(ModalRoute.withName('/Home'));
        break;

      case ERROR.invalid_input:
        final snackBar = SnackBar(
          content: Text('INVALID INPUT',
            style: TextStyle(color: Colors.red, fontSize: 20)));
      
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        break;
    }
  }

}