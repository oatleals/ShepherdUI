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

  Map<String, dynamic> toMap() {
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
}

