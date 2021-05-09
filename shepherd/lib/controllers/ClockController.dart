import 'package:shepherd/connectivity/ConnectionChecker.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:shepherd/location/LocationFinder.dart';
import 'package:shepherd/errors.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ERROR> clock(
  bool clockin,
  int clientId, 
  int token) async
{
  if (clientId.toString().length != 6 || token.toString().length != 6)
    return ERROR.invalid_input;

  var postSuccess = false;
  final connection = new ConnectionChecker();
  final sharedPreferences = await SharedPreferences.getInstance();

  final localDBContainer = new LocalDBContainer();
  await localDBContainer.init();

  final locationFinder = new LocationFinder();
  await locationFinder.getLocation();
  
  WorkData workData = new WorkData(
    isClockIn: clockin,
    userId: sharedPreferences.getInt('userId'),
    clientId: clientId,
    token: token,
    time: locationFinder.locationData.time,
    latitude: locationFinder.locationData.latitude,
    longitude: locationFinder.locationData.longitude
  );

  final test = await connection.isConnected();
  print('');

  if (await connection.isConnected())
  {
    final url = clockin ? 
      Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-in'):
      Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-out');

    final client = Client();
    final response = await client.post(url, body: workData.serializeForEVV());
    client.close();

    print(response.statusCode);
    postSuccess = response.statusCode == 200;
  }

  localDBContainer.insert(workData);
  sharedPreferences.setBool('isClockedIn', clockin);

  return postSuccess ? 
    ERROR.success :
    ERROR.http_failed;
}