class WorkData {
  int isClockIn;
  int isAuthenticated;

  int userId;

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

  Map<String, dynamic> stringObjMap() {
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

  Map<String, String> stringStringMap() {
    return {
      'isClockIn': isClockIn.toString(),
      'userId': userId.toString(),
      'clientId': clientId.toString(),
      'token': token.toString(),
      'time': time.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'tasks': tasks.toString(),
      'isAuthenticated': isAuthenticated.toString()
    };
  }
}
