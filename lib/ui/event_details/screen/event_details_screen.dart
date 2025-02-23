import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/core/get_location_name.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home_screen/screen/home_screen.dart';
import 'package:evently/ui/update_event/screen/update_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class EventDetailsScreen extends StatefulWidget {
  static const String routeName = "Event Details";

  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();

}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Future<String?> locationFuture;
  Event? args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (args == null) {
      // Now you can safely access args after build context is initialized
      args = ModalRoute.of(context)?.settings.arguments as Event;

      // Fetch location name here
      locationFuture = GetLocationName.getLocationName(args!.lat!, args!.lng!);
    }
  }

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context)?.settings.arguments as Event;
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    locationProvider.getLocation();
    double height = MediaQuery.of(context).size.height;

    // Creating a custom marker with a custom icon
    Marker eventMarker = Marker(
      markerId: MarkerId(args.id!),
      position: LatLng(args.lat!, args.lng!), // Using the lat and lng args
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange), // Custom hue (color)
      infoWindow: InfoWindow(title: args.title), // InfoWindow showing event title
    );

    locationProvider.markers.add(eventMarker); // Add the marker to the provider's list

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorManger.lightPrimary),
          title: Text(
            StringsManger.event_details.tr(),
            style: TextStyle(color: ColorManger.lightPrimary),
          ),
          actions: args.userId == FirebaseAuth.instance.currentUser!.uid
              ? [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, UpdateEventScreen.routeName,arguments: args);
                  },
                  child: SvgPicture.asset(AssetsManger.edit_tool)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                  onTap: () {
                    deleteEventDialog(args);
                  },
                  child: SvgPicture.asset(AssetsManger.delete_tool)),
            ),
          ]
              : [],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                height: height * 0.2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      getImageByCategory(args),
                      height: height * 0.2,
                      fit: BoxFit.cover,
                    )),
              ),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    args.title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Gap(16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorManger.lightPrimary)),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetsManger.date_details_mark),
                    Gap(8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMMd(context.locale.languageCode)
                                .format(args.date!.toDate()),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat.Hm(context.locale.languageCode)
                                .format(args.date!.toDate()),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorManger.lightPrimary)),
                child: Row(
                  children: [
                    SvgPicture.asset(AssetsManger.chooseLocation),
                    Gap(8),
                    Expanded(
                        child:  FutureBuilder<String?>(
                          future: locationFuture, // Fetch location name
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading spinner
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}'); // Handle error
                            } else if (snapshot.hasData) {
                              return Text(
                                snapshot.data!,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: ColorManger.lightPrimary,
                                ),
                              );
                            } else {
                              return Text('No location found'); // Fallback message
                            }
                          },
                        ),
                    ),
                    Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: ColorManger.lightPrimary,
                        ))
                  ],
                ),
              ),
              Gap(16),
              Container(
                width: double.infinity,
                height: height * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: ColorManger.lightPrimary)),
                child: GoogleMap(
                  myLocationEnabled: true,
                  onTap: (location) {
                    locationProvider.chooseEventLocation(location);
                    Navigator.pop(context, location);
                  },
                  mapType: MapType.normal,
                  markers: locationProvider.markers,
                  initialCameraPosition: locationProvider.cameraPosition,
                  onMapCreated: (mapController) {
                    locationProvider.mapController = mapController;
                  },
                ),
              ),
              Gap(16),
              Text(
                StringsManger.desc.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gap(8),
              Text(args.description!,
                  style: Theme.of(context).textTheme.titleSmall)
            ]),
          ),
        ));
  }

  late ThemeProvider themeProvider;

  String getImageByCategory(Event event) {
    if (event.category == sportCategory) {
      if (themeProvider.currentTheme == ThemeMode.dark) {
        return AssetsManger.sportcard;
      }
      return AssetsManger.sport_card_light;
    } else if (event.category == birthDayCategory) {
      if (themeProvider.currentTheme == ThemeMode.dark) {
        return AssetsManger.birtday_dark;
      }
      return AssetsManger.birtday_dark;
    } else {
      if (themeProvider.currentTheme == ThemeMode.dark) {
        return AssetsManger.book_club;
      }
      return AssetsManger.book_club;
    }
  }
  deleteEvent(Event event){
    DialogUtils.showLoadingDialog(context);
    FireStoreHandler.deleteEvent(event);
    Navigator.pop(context);
    DialogUtils.showToast("Event deleted");
    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false,);
  }
  deleteEventDialog(Event event){
    DialogUtils.showMessageDialog(
        context: context,
        message: StringsManger.confirm_delete_event.tr(),
        buttonTitle2: StringsManger.cancel.tr(),
        positiveBtnClick2: (){
          Navigator.pop(context);
        },
        buttonTitle: StringsManger.ok.tr(),
        positiveBtnClick: (){
          deleteEvent(event);
        });
  }
}
