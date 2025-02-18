import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  Location location=Location();
  String locationMsg="";
  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15.0,
  );
  Set<Marker>markers={
  Marker(
    markerId: MarkerId("0"),
    position:LatLng(37.42796133580664, -122.085749655962),
  )
  };
  LatLng? eventLocation;



  Future<void> getLocation()async{
    locationMsg="Checking Location Service";
  bool locationAccess=await getPermission();
    if(!locationAccess){
    locationMsg="Location Permission Denied";
    notifyListeners();
    return;
    }
    bool locationServiceEnable=await serviceEnabled();
    if(!locationServiceEnable){
      locationMsg="Location Service Disabled";
      notifyListeners();
      return;
    }

    LocationData locationData=await location.getLocation();
    changeLocationOnMap(locationData);
    notifyListeners();
  }




  Future<bool> serviceEnabled()async{
    bool locationServiceEnable=await location.serviceEnabled();
    if(!locationServiceEnable){
      locationServiceEnable=await location.requestService();
    }
    return locationServiceEnable;
  }
  Future<bool> getPermission()async{
  var permissionStatus=await location.hasPermission();
  if(permissionStatus==PermissionStatus.denied){
    permissionStatus=await location.requestPermission();
  }
  return permissionStatus==PermissionStatus.granted;
  }
  void setLocationListeners(){
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000
    );
    location.onLocationChanged.listen((location){
      changeLocationOnMap(location);
    });
  }
  void changeLocationOnMap(LocationData locationData){
    cameraPosition=CameraPosition(
        target: LatLng(locationData.latitude??0, locationData.longitude??0),
        zoom: 15.0);
    markers={
      Marker(
        markerId: MarkerId("0"),
        position:LatLng(locationData.latitude??0, locationData.longitude??0),
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
  void chooseEventLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    notifyListeners();
  }
}