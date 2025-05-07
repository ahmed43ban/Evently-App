import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'as myGeo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  Location location = Location();
  String locationMsg = "";
  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15.0,
  );
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };
  LatLng? eventLocation;
  List<Map<String, dynamic>> streetCoordinates = [];

  Future<void> getLocation() async {
    locationMsg = "Checking Location Service";
    bool locationAccess = await getPermission();
    if (!locationAccess) {
      locationMsg = "Location Permission Denied";
      notifyListeners();
      return;
    }
    bool locationServiceEnable = await serviceEnabled();
    if (!locationServiceEnable) {
      locationMsg = "Location Service Disabled";
      notifyListeners();
      return;
    }

    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData);
    notifyListeners();
  }

  Future<bool> serviceEnabled() async {
    bool locationServiceEnable = await location.serviceEnabled();
    if (!locationServiceEnable) {
      locationServiceEnable = await location.requestService();
    }
    return locationServiceEnable;
  }

  Future<bool> getPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  void setLocationListeners() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    location.onLocationChanged.listen((location) {
      changeLocationOnMap(location);
    });
  }

  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
        zoom: 15.0);
    markers = {
      Marker(
        markerId: MarkerId("0"),
        position:
            LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void chooseEventLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    notifyListeners();
  }
  Future<void> getCoordinatesFromStreetName(String streetName) async {
    try {
      List<myGeo.Location> locations = await myGeo.locationFromAddress(streetName);
      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        // Add coordinates to the list
        streetCoordinates.add({
          'street': streetName,
          'latitude': latitude,
          'longitude': longitude
        });

        // Add marker on the map
        markers.add(
          Marker(
            markerId: MarkerId(streetName),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: streetName),
          ),
        );

        // Print all coordinates to the console once the street is added
        print("All Coordinates: $streetCoordinates");

        // Notify listeners to update UI (map)
        notifyListeners();
      }
    } catch (e) {
      print("Error getting coordinates for $streetName: $e");
    }
  }
  /*Future<void> getCoordinatesFromStreetName(String streetName) async {
    try {
      // استخدام geocoding لتحويل اسم الشارع إلى إحداثيات
      List<myGeo.Location> locations = await myGeo.locationFromAddress(streetName);
      if (locations.isNotEmpty) {
        LatLng newLocation = LatLng(locations[0].latitude, locations[0].longitude);

        // إضافة الماركر على الخريطة
        markers.add(
          Marker(
            markerId: MarkerId("streetMarker"),
            position: newLocation,
            infoWindow: InfoWindow(title: streetName),
          ),
        );

        // تغيير مكان الكاميرا على الخريطة
        cameraPosition = CameraPosition(target: newLocation, zoom: 15.0);
        mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        print("Coordinates for $streetName: ${newLocation.latitude}, ${newLocation.longitude}");

        notifyListeners();
      }
    } catch (e) {
      print("Error getting coordinates: $e");
    }
  }*/
}
