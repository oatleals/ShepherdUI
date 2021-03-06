import 'dart:convert';

class WorkData {
  bool isClockIn;
  int isAuthenticated;
  int userId;

  // These values are serialized and sent to the EVV.
  int clientId;
  int officeId;
  int token;
  double time;
  double latitude;
  double longitude;

  List<String> tasks;

  WorkData(
      {this.isClockIn,
      this.userId,
      this.clientId,
      this.officeId,
      this.token,
      this.time,
      this.latitude,
      this.longitude,
      this.tasks,
      this.isAuthenticated});

  Map<String, dynamic> serializeForLocalDB() {
    return {
      'isClockIn': isClockIn,
      'userId': userId,
      'clientId': clientId,
      'token': token,
      'time': time,
      'latitude': latitude,
      'longitude': longitude,
      'tasks': tasks,
      'isAuthenticated': isAuthenticated
    };
  }

  String serializeForEVV() {
    return jsonEncode(
      isClockIn ? {
        'time_stamp': '2021-03-27 00:00:00',
        'client_id': clientId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'office_id' : officeId.toString(),
        'one_time_password': token.toString(),
      } :
      {
        'time_stamp': '2021-03-27 00:00:00',
        'client_id': clientId.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'tasks_performed': [""],
        'office_id' : officeId.toString(),
        'one_time_password': token.toString(),
      }
    );
  }
  
}