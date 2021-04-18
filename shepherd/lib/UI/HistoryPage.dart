import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 40.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomeView(title: "History Page"),
    );
  }
}

List historyDateList = [
  "Jan. 12",
  "Apr. 4",
  "May 2",
  "Aug. 23",
  "Dec 3",
  "Jan. 12",
  "Apr. 4",
  "May 2",
  "Aug. 23",
  "Dec 3",
  "Jan. 12",
  "Apr. 4",
  "May 2",
  "Aug. 23",
  "Dec 3",
  "Jan. 12",
  "Apr. 4",
  "May 2",
  "Aug. 23",
  "Dec 3",
];

List historyHouseList = [
  "House 1",
  "House 2",
  "House 3",
  "House 4",
  "House 5",
  "House 6",
  "House 7",
  "House 8",
  "House 9",
  "House 10",
  "House 11",
  "House 12",
  "House 13",
  "House 14",
  "House 15",
  "House 16",
  "House 17",
  "House 18",
  "House 19",
  "House 20",
];

final List colorsOfMonth = [
  Colors.blue[900],
  Colors.indigo[200],
  Colors.tealAccent[400],
  Colors.red[200],
  Colors.pink[300],
  Colors.deepOrange,
  Colors.yellowAccent,
  Colors.lightGreen,
  Colors.deepPurple,
  Colors.brown[200],
  Colors.brown[400],
  Colors.blueGrey
];

colorsFunction() {
  final randomColor = new Random();
  var element = colorsOfMonth[randomColor.nextInt(colorsOfMonth.length)];
  return element;
}

class HomeView extends StatelessWidget {
  final String title;
  HomeView({this.title});

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.white, width: 3)),
            backgroundColor: Colors.blue[200],
            title: Text("History"),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                onPressed: () {},
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text('My Work History'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: historyDateList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                )),
                hoverColor: Colors.grey[100],
                tileColor: Colors.blue[100],
                onTap: () {
                  createAlertDialog(context);
                },
                title: Center(
                  child: Text(
                    historyHouseList[index],
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: colorsFunction(),
                  child: Text(
                    historyDateList[index],
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
