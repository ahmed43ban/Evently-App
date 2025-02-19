import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/event_details/screen/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  Event event;

  EventItem({required this.event, super.key});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EventDetailsScreen.routeName,
            arguments: widget.event);
      },
      child: Container(
        height: height * 0.25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: AssetImage(getImageByCategory()), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Text(
                      widget.event.date!.toDate().day.toString(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat.MMM(context.locale.languageCode)
                          .format(widget.event.date!.toDate()),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.outline),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      widget.event.title!,
                      style: Theme.of(context).textTheme.displaySmall,
                    )),
                    InkWell(
                      onTap: () async {
                        if (widget.event.isWishList ?? false) {
                          DialogUtils.showLoadingDialog(context);
                          await FireStoreHandler.removeFromFavorite(
                              FirebaseAuth.instance.currentUser!.uid,
                              widget.event.id!);
                          widget.event.isWishList = false;
                          setState(() {});
                          Navigator.pop(context);
                        } else {
                          DialogUtils.showLoadingDialog(context);
                          await FireStoreHandler.addToFavorite(
                              FirebaseAuth.instance.currentUser!.uid,
                              widget.event);
                          widget.event.isWishList = true;
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: SvgPicture.asset(
                        widget.event.isWishList!
                            ? AssetsManger.loveSelected
                            : AssetsManger.loveUnSelected,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            ColorManger.lightPrimary, BlendMode.srcIn),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  late ThemeProvider themeProvider;

  String getImageByCategory() {
    if (widget.event.category == sportCategory) {
      if (themeProvider.currentTheme == ThemeMode.dark) {
        return AssetsManger.sportcard;
      }
      return AssetsManger.sport_card_light;
    } else if (widget.event.category == birthDayCategory) {
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
}
