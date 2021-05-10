import 'package:flutter/material.dart';

import '../errors.dart';

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

void showSnackbar(BuildContext context, ERROR status) 
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