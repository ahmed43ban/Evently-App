import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/core/get_location_name.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/reusable_componenes/customField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/event_location/screen/event_location_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class UpdateEventScreen extends StatefulWidget {
  static const String routeName = "update_Event";

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  int selectedIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late LocationProvider locationProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    locationProvider = Provider.of<LocationProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
    locationProvider.eventLocation = null;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    Event args = ModalRoute.of(context)?.settings.arguments as Event;
    locationProvider = Provider.of<LocationProvider>(context);
    locationProvider.getLocation();
    double height = MediaQuery.of(context).size.height;

    // Creating a custom marker with a custom icon
    Marker eventMarker = Marker(
      markerId: MarkerId(args.id!),
      position: LatLng(args.lat!, args.lng!), // Using the lat and lng args
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange), // Custom hue (color)
      infoWindow: InfoWindow(title: args.title), // InfoWindow showing event title
    );
    locationProvider.markers.add(eventMarker);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManger.lightPrimary),
        title: Text(
          StringsManger.edit_event.tr(),
          style: TextStyle(color: ColorManger.lightPrimary),
        ),
      ),
      body: Form(
        key: formKey,
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.2,
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                themeProvider.currentTheme==ThemeMode.dark
                                    ?AssetsManger.book_club
                                    :AssetsManger.book_club_light,
                                height: height * 0.2,
                                fit: BoxFit.cover,
                              )),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                themeProvider.currentTheme==ThemeMode.dark
                                    ?AssetsManger.sportcard
                                    :AssetsManger.sportcard,
                                height: height * 0.2,
                                fit: BoxFit.cover,
                              )),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                themeProvider.currentTheme==ThemeMode.dark
                                    ?AssetsManger.birtday_dark
                                    :AssetsManger.birthday,
                                height: height * 0.2,
                                fit: BoxFit.cover,
                              )),
                        ]),
                  ),
                  Gap(16),
                  TabBar(
                      onTap: (index) {
                        selectedIndex = index;
                        setState(() {});
                      },
                      labelColor: Colors.white,
                      unselectedLabelColor: ColorManger.lightPrimary,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerHeight: 0,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorManger.lightPrimary),
                                borderRadius: BorderRadius.circular(46)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManger.book_event,
                                  colorFilter: ColorFilter.mode(
                                      selectedIndex == 0
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryFixedVariant,
                                      BlendMode.srcIn),
                                  height: 24,
                                  width: 24,
                                ),
                                Gap(8),
                                Text(StringsManger.book_club.tr())
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorManger.lightPrimary),
                                borderRadius: BorderRadius.circular(46)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManger.sport_event,
                                  colorFilter: ColorFilter.mode(
                                      selectedIndex == 1
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryFixedVariant,
                                      BlendMode.srcIn),
                                  height: 24,
                                  width: 24,
                                ),
                                Gap(8),
                                Text(StringsManger.sport.tr())
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorManger.lightPrimary),
                                borderRadius: BorderRadius.circular(46)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManger.cake_event,
                                  colorFilter: ColorFilter.mode(
                                      selectedIndex == 2
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryFixedVariant,
                                      BlendMode.srcIn),
                                  height: 24,
                                  width: 24,
                                ),
                                Gap(8),
                                Text(StringsManger.birthday.tr())
                              ],
                            ),
                          ),
                        ),
                      ]),
                  Gap(16),
                  Text(
                    StringsManger.title.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Gap(8),
                  CustomField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManger.not_empty.tr();
                        }
                        return null;
                      },
                      hint: args.title!,
                      prefix: AssetsManger.writeText,
                      controller: titleController,
                      keyboard: TextInputType.text),
                  Gap(8),
                  Text(
                    StringsManger.desc.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  CustomField(
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManger.not_empty.tr();
                        }
                        return null;
                      },
                      hint: args.description!,
                      controller: descController,
                      keyboard: TextInputType.multiline),
                  Gap(16),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManger.date_mark,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.secondary,
                            BlendMode.srcIn),
                      ),
                      Gap(8),
                      Expanded(
                        child: Text(
                          StringsManger.event_date.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {
                              chooseEventDate();
                            },
                            child: Text(
                                selectedDate != null
                                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                    : DateFormat.yMd(context.locale.languageCode)
                                    .format(args.date!.toDate()),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: ColorManger.lightPrimary,
                                    ))),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManger.time_mark,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.secondary,
                              BlendMode.srcIn)),
                      Gap(8),
                      Expanded(
                        child: Text(
                          StringsManger.event_time.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {
                              chooseEventTime();
                            },
                            child: Text(
                                selectedTime == null
                                    ?DateFormat.Hm(context.locale.languageCode)
                                    .format(args.date!.toDate())
                                    : "${selectedTime!.hourOfPeriod}:${selectedTime!.minute}${selectedTime!.period.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: ColorManger.lightPrimary,
                                    ))),
                      )
                    ],
                  ),
                  Text(
                    StringsManger.location.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, EventLocationScreen.routeName);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ColorManger.lightPrimary)),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsManger.chooseLocation),
                          Gap(8),
                          Expanded(
                            child: FutureBuilder<String?>(
                              future: locationProvider.eventLocation!=null?
                              GetLocationName.getLocationName(
                                  locationProvider.eventLocation!.latitude,
                                  locationProvider.eventLocation!.longitude)
                                  :GetLocationName.getLocationName(
                                eventMarker.position.latitude,
                                eventMarker.position.longitude),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Text(
                                    "loading",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: ColorManger.lightPrimary),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    "error_loading_location",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: ColorManger.lightPrimary),
                                  );
                                } else if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data ?? StringsManger.choose_location.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: ColorManger.lightPrimary),
                                  );
                                } else {
                                  return Text(
                                    StringsManger.choose_location.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: ColorManger.lightPrimary),
                                  );
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
                  ),
                  Gap(8),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                        title: StringsManger.update_event.tr(),
                        onPressed: () {
                          updateEvent();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  chooseEventDate() async {
    DateTime? tempDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (tempDate != null) {
      selectedDate = tempDate;
      setState(() {});
    }
  }

  chooseEventTime() async {
    TimeOfDay? tempDate = await showTimePicker(
      context: context,
      initialTime: selectedTime != null ? selectedTime! : TimeOfDay.now(),
    );
    if (tempDate != null) {
      selectedTime = tempDate;
      setState(() {});
    }
  }

  updateEvent() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate != null && selectedTime != null) {
        if (locationProvider.eventLocation != null) {
          DateTime eventDate = DateTime(selectedDate!.year, selectedDate!.month,
              selectedDate!.day, selectedTime!.hour, selectedTime!.minute);
          DialogUtils.showLoadingDialog(context);
          await FireStoreHandler.updateEvent(Event(
              title: titleController.text,
              description: descController.text,
              date: Timestamp.fromDate(eventDate),
              userId: FirebaseAuth.instance.currentUser!.uid,
              category: getSelectedCategory(),
              lat: locationProvider.eventLocation!.latitude,
              lng: locationProvider.eventLocation!.longitude));
          Navigator.pop(context);
          DialogUtils.showToast("Event Added success");
        } else {
          DialogUtils.showToast("Location Should Entered");
        }
      } else {
        DialogUtils.showToast("Please Enter Date and Time");
      }
    }
  }

  String getSelectedCategory() {
    if (selectedIndex == 0) {
      return bookCategory;
    } else if (selectedIndex == 1) {
      return sportCategory;
    } else {
      return birthDayCategory;
    }
  }
}
