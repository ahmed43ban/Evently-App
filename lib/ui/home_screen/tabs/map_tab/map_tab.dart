import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late LocationProvider locationProvider;
  List<String> streets = [
    "ابومرقيق, ك 35, عزبة عيسى, مرسى مطروح",
    "شارع الشاطئ, خلف استراحة النقل والمواصلات, مرسى مطروح",
    "شارع الذاعة, امام السجل المدني, ك 4, منزل جمال فؤاد, مرسى مطروح",
    "وادى الرمل, ك 5, طريق السلوم, مرسى مطروح",
    "بجوار فندق القصر, عزبة السنوسية, شارع 5, الدور الثالث, مرسى مطروح"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.getLocation();
    locationProvider.setLocationListeners();
    for (var street in streets) {
      locationProvider.getCoordinatesFromStreetName(street);
    }
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
