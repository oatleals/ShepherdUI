// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shepherd/provider/GlobalState.dart';


void main() {
  test('''Initial route for top button in HomePage takes the user to ClockInForm. 
        After clocking in, the button changes its route''', () 
  {
    GlobalState globalState = new GlobalState(null);
    expect(globalState.clockButtonRoute, '/ClockIn');

    globalState.clockIn();
    expect(globalState.clockButtonRoute, '/ClockOut');

    globalState.clockOut();
    expect(globalState.clockButtonRoute, '/ClockIn');
  });
}
