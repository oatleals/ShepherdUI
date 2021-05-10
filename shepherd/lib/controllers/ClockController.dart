import 'package:shepherd/connectivity/ConnectionChecker.dart';
import 'package:shepherd/domain_data/EmployeeData.dart';
import 'package:shepherd/domain_data/LocalDBContainer.dart';
import 'package:shepherd/domain_data/WorkData.dart';
import 'package:shepherd/location/LocationFinder.dart';
import 'package:shepherd/errors.dart';
import 'package:shepherd/domain_data/EmployeeData.dart';


import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ERROR> clock(
  bool clockin,
  int clientId, 
  int token,
  int officeid) async
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
    officeId: officeid,
    token: token,
    time: locationFinder.locationData.time,
    latitude: locationFinder.locationData.latitude,
    longitude: locationFinder.locationData.longitude
  );

  if (await connection.isConnected())
  {
    final url = 'evv_server_is_down';
    /*
    final url = clockin ? 
      Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-in'):
      Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-out');*/

    final client = Client();
    final response = await client.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'}, 
      body: workData.serializeForEVV());

    client.close();

    print(response.statusCode);
    postSuccess = response.statusCode == 200;
  }

  localDBContainer.insert(workData);
  sharedPreferences.setBool('isClockedIn', clockin);
  sharedPreferences.setInt('officeId', officeid);

  return postSuccess ? 
    ERROR.success :
    ERROR.http_failed;
}


Future<ERROR> requestEmailPassword(int userId) async 
{
  final userIdText = userId.toString();
  final url = 'http://54.158.192.252/employee/email_service/email/' + userIdText;

  print(url);

  final client = Client();
  final response = await client.get(url);

  print(response.body);

  client.close();

  print(response.statusCode);
  final success = response.statusCode == 200;

  return success ?
    ERROR.success
    : ERROR.http_failed;
}

Future<ERROR> testEmployeeInfoConnection(
  String lastName,
  String firstName,
  int employeeId,
  int emplyoeePhoneNumber,
  String employeeEmail,
  int officeId) async
{
  final sharedPreferences = await SharedPreferences.getInstance();
  final url = 'http://54.158.192.252/employee/table/';
  /*
  final url = clockin ? 
    Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-in'):
    Uri.parse('http://ec2-52-23-212-121.compute-1.amazonaws.com:8080/evv/clock-out');*/

  EmployeeData employeeData = new EmployeeData(
    firstname: 'john',
    lastname: 'doe',
    employeeId: sharedPreferences.getInt('employeeId'),
    phonenumber: 3142222222,
  );

  final client = Client();
  final response = await client.post(
    url,
    headers: <String, String>{'Content-Type': 'application/json'}, 
    body: employeeData.serializeForEmployeeInfo());

  client.close();

  print(response.statusCode);
  final postSuccess = response.statusCode == 200;

  return postSuccess? 
    ERROR.success
    : ERROR.http_failed;
}


