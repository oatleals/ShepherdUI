<<<<<<< HEAD
class WorkData {
  bool isClockIn;
  bool isAuthenticated;
=======
class WorkData
{
  int isClockIn;
  int isAuthenticated;
>>>>>>> 1e7517a633a9386cfbc8b90495c71d5651d41da2

  int userId;

  int clientId;
  int token;

  double time;
  double latitude;
  double longitude;

  List<String> tasks;

  WorkData(
<<<<<<< HEAD
      {this.isClockIn,
      this.userId,
      this.clientId,
      this.clientPass,
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
      'clientPass': clientPass,
      'time': time,
      'latitude': latitude,
      'longitude': longitude,
      'tasks': tasks,
      'isAuthenticated': isAuthenticated
=======
    {this.isClockIn, this.userId, this.clientId, this.token, 
    this.time, this.latitude, this.longitude, this.tasks, this.isAuthenticated});

  Map<String, dynamic> stringObjMap() {
    return {
      'isClockIn' : isClockIn,
      'userId' : userId,
      'clientId' : clientId,
      'token' : token,
      'time' : time,
      'latitude' : latitude,
      'longitude' : longitude,
      'tasks' : tasks,
      'isAuthenticated' : isAuthenticated
>>>>>>> 1e7517a633a9386cfbc8b90495c71d5651d41da2
    };
  }

  Map<String, String> stringStringMap() {
    return {
      'isClockIn' : isClockIn.toString(),
      'userId' : userId.toString(),
      'clientId' : clientId.toString(),
      'token' : token.toString(),
      'time' : time.toString(),
      'latitude' : latitude.toString(),
      'longitude' : longitude.toString(),
      'tasks' : tasks.toString(),
      'isAuthenticated' : isAuthenticated.toString()
    };
  }
}