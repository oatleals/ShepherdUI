import 'package:connectivity/connectivity.dart';

class ConnectionChecker
{
  Future<bool> isConnected() async
  {
    final connectivityResult = await (Connectivity().checkConnectivity());
    
    if (connectivityResult == ConnectivityResult.mobile || 
        connectivityResult == ConnectivityResult.wifi) 
    {
      return true;
    } 

    return false;
  }
}