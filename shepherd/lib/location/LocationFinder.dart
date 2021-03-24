import 'package:location/location.dart';

class LocationFinder 
{
  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  // this is the object that holds latitude, longitude, and time.
  LocationData locationData; 

  LocationFinder()
  {
    location = new Location();
  }

  Future<void> init() async 
  {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled)  _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) return;
      
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) 
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    
    locationData = await location.getLocation();  
  } 
}