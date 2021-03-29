import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shepherd/controllers/ClockController.dart';
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
    GlobalState globalState = Provider.of<GlobalState>(context);
    String clientID = globalState.clientId;
    int numTasks = globalState.numTasks;

    var top2 = 10;
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
                      Text("$clientID", 
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
                    controller: globalState.clockOutPassController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2
                        )
                      ),
                      labelText: 'Password'
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
              height: 150,
              child: SingleChildScrollView(
                child: TextField(
                  decoration:InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      )
                    ),
                    labelText: 'Tasks'
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            ClockController.clockOut(context);
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

  void recursiveShowDialog(int numTasks)
  {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.white, width: 3)
              ),
              backgroundColor: Colors.blue[200],
              content: Container(
                child: SingleChildScrollView(
                  child: Consumer<GlobalState>(
                    builder: (context, globalState, child) {
                      List<Widget> rows = [];
                      
                      for (int i = 0; i < numTasks; i++)
                      {
                        globalState.taskControllers.add(
                          new TextEditingController());

                        var icon;
                        if (i == numTasks -1)
                        {
                          icon = IconButton(
                            icon: Icon(Icons.add, color: Colors.blue),
                            onPressed: () { 
                              this.setState(() {
                                globalState.newTask();
                                Navigator.of(context).pop();
                                recursiveShowDialog(globalState.numTasks);
                              });
                            }
                          );
                        }
                        else
                        {
                          icon = IconButton(
                            icon: Icon(Icons.remove, color: Colors.blue),
                            onPressed: () { 
                              this.setState(() {
                                globalState.taskControllers.removeAt(i);
                                globalState.numTasks--;
                                Navigator.of(context).pop();
                                recursiveShowDialog(globalState.numTasks);
                              });
                            }
                          );
                        } 
                                                
                        var textField = Container(width: 175, child: TextField(
                          controller: globalState.taskControllers[i],
                          style: TextStyle(
                            fontSize:16,
                            color: Colors.blue
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2
                              )
                            )
                          ),
                          obscureText: false));

                        var row = new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [textField, icon]);
                        
                        rows.add(row);
                      }

                      return Column(
                        children: rows);
                    }
                  )
                ),
              )
            );
          }
        );
      }
    );
  }

}