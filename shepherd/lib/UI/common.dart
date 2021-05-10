import 'package:flutter/material.dart';

showProgressIndicatorAlertDialog(BuildContext context) {
  showDialog<AlertDialog>(
    context: context,
    builder: (context) {
      return Scaffold(
        drawerScrimColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        body: Builder(builder: (context) {
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
                )
              )
            );
          }
        ),
      );
    }
  ); 
}