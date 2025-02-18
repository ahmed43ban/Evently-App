import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventLocationScreen extends StatefulWidget {
  static const String routeName="Event Location";
  const EventLocationScreen({super.key});

  @override
  State<EventLocationScreen> createState() => _EventLocationScreenState();
}

class _EventLocationScreenState extends State<EventLocationScreen> {
  late LocationProvider locationProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationProvider=Provider.of<LocationProvider>(context,listen:false );
    locationProvider.getLocation();
  }
  @override
  Widget build(BuildContext context) {
    locationProvider=Provider.of<LocationProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child:GoogleMap(
                  onTap: (location){
                    locationProvider.chooseEventLocation(location);
                    Navigator.pop(context,location);
                  },
                  mapType: MapType.normal,
                  markers: locationProvider.markers,
                  initialCameraPosition: locationProvider.cameraPosition,
                  onMapCreated: (mapController){
                    locationProvider.mapController=mapController;
                  },
                ) ),
            Container(
              width: double.infinity,
              color: ColorManger.lightPrimary,
              padding: EdgeInsets.all(16),
              child: Text(StringsManger.tap_to_select.tr(),style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white
              ),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
