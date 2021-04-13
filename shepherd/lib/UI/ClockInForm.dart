import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd/controllers/ClockController.dart';


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
    var clientIdTextController = new TextEditingController();
    var tokenTextController = new TextEditingController();

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
            final prefs = await SharedPreferences.getInstance();
            prefs.setInt('clientId', int.parse(clientIdTextController.text));
            prefs.setInt('token', int.parse(tokenTextController.text));
            await ClockController.clockIn(
              context: context,
              clientId: int.parse(clientIdTextController.text),
              token: int.parse(tokenTextController.text)
            );
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