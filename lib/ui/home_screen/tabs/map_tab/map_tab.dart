import 'package:evently/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late LocationProvider locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.getLocation();
    locationProvider.setLocationListeners();
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    return Consumer<LocationProvider>(
      builder: (context, provider, child) => SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                provider.getLocation();
              },
              child: Icon(Icons.gps_fixed),
            ),
            body: Column(
              children: [
                Expanded(
                    child: GoogleMap(
                  mapType: MapType.normal,
                  markers: provider.markers,
                  initialCameraPosition: provider.cameraPosition,
                  onMapCreated: (mapController) {
                    provider.mapController = mapController;
                  },
                ))
              ],
            )),
      ),
    );
  }
}
