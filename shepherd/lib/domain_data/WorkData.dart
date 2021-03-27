class WorkData
{
  bool isClockIn;
  bool isAuthenticated;

  int userId;

  int clientId;
  int clientPass;

  double time;
  double latitude;
  double longitude;

  List<String> tasks;

  WorkData(
    {this.isClockIn, this.userId, this.clientId, this.clientPass, 
    this.time, this.latitude, this.longitude, this.tasks, this.isAuthenticated});

  Map<String, dynamic> stringObjMap() {
    return {
      'isClockIn' : isClockIn,
      'userId' : userId,
      'clientId' : clientId,
      'clientPass' : clientPass,
      'time' : time,
      'latitude' : latitude,
      'longitude' : longitude,
      'tasks' : tasks,
      'isAuthenticated' : isAuthenticated
    };
  }

  Map<String, String> stringStringMap() {
    return {
      'isClockIn' : isClockIn.toString(),
      'userId' : userId.toString(),
      'clientId' : clientId.toString(),
      'clientPass' : clientPass.toString(),
      'time' : time.toString(),
      'latitude' : latitude.toString(),
      'longitude' : longitude.toString(),
      'tasks' : tasks.toString(),
      'isAuthenticated' : isAuthenticated.toString()
    };
  }
}

