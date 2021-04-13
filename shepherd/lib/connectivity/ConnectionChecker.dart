import 'package:connectivity/connectivity.dart';

class ConnectionChecker
{
  Future<bool> isConnected() async
  {
    var connectivityResult = await (Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.mobile)
      //|| connectivityResult == ConnectivityResult.wifi) 
    {
      return true;
    } 

    return false;
  }
}