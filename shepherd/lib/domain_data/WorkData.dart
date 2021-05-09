class WorkData {
  int isClockIn;
  int isAuthenticated;
  int userId;

  // These values are serialized and sent to the EVV.
  int clientId;
  int token;
  double time;
  double latitude;
  double longitude;

  List<String> tasks;

  WorkData(
      {this.isClockIn,
      this.userId,
      this.clientId,
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

  Map<String, String> serializeForEVV() {
    return {
      'client_id': 'REMOVETHISENTRY',
      'one_time_password': token.toString(),
      'time_stamp': time.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'office_id' : "1"
    };
  }
}