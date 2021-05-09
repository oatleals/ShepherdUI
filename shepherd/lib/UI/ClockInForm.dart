import 'package:flutter/material.dart';
import 'package:shepherd/controllers/ClockController.dart';

import '../errors.dart';


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
                style: TextStyle(
                  fontSize:35,
                  color: Colors.blue
                ),
                controller: clientIdTextController,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2
                    ),
                  ),              
                  labelText: 'Client ID'
                ),
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
                  style: TextStyle(
                    fontSize:35,
                    color: Colors.blue
                  ),
                  controller: tokenTextController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2
                      ),
                    ),
                    labelText: 'Token'
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.camera_alt, size: 30, color: Colors.blue),
                onPressed: (){}, // For scanning token.
              )
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async
          { 
            final status = await clock(
              true, // is clock in
              int.parse(clientIdTextController.text),
              int.parse(tokenTextController.text)
            );

            showSnackbar(status);
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

  void showSnackbar(ERROR status) 
  {
    switch (status)
    {
      case ERROR.success:
        final snackBar = SnackBar(
          content: Row(
            children: [
              Text('Clock In: ',
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
              Text('Clock In: ',
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
              Text('Clock In: ',
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