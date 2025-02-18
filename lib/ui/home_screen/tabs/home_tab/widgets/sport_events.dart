import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/model/Event.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SportEvents extends StatelessWidget {
  const SportEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireStoreHandler.getCategoryEvents(sportCategory),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return DialogUtils.showMessageDialog(
              context: context, message: snapshot.error!.toString(),
              buttonTitle: StringsManger.ok.tr(),
              positiveBtnClick: (){
                Navigator.pop(context);
              });
        }else{
          List<Event> events=snapshot.data??[];
          return events.isEmpty
              ?Text(StringsManger.no_events_yet.tr())
              :ListView.separated(
              itemBuilder: (context, index) => EventItem(event: events[index],),
              separatorBuilder: (context, index) => Gap(16),
              itemCount: events.length);
        }
      },);
  }
}