import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName="createEvent";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:ColorManger.lightPrimary
        ),
        title: Text(StringsManger.create_event.tr(),style: TextStyle(
          color: ColorManger.lightPrimary
        ),),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: height*0.25,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                    children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                      child: Image.asset(AssetsManger.book_club,height: height*0.25,fit: BoxFit.cover,)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                      child: Image.asset(AssetsManger.sportcard,height: height*0.25,fit: BoxFit.cover,)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                      child: Image.asset(AssetsManger.birthday,height: height*0.25,fit: BoxFit.cover,)),
                ]),
              ),
              Gap(16),
              TabBar(
                  onTap: (index){
                    selectedIndex=index;
                    setState(() {

                    });
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
                    Tab(child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManger.lightPrimary
                          ),
                          borderRadius: BorderRadius.circular(46)
                      ),
                      padding: EdgeInsets.all( 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsManger.book_event,colorFilter: ColorFilter.mode(
                              selectedIndex==0
                                  ?Colors.white
                                  :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                              BlendMode.srcIn),
                            height: 24,width: 24,),
                          Gap(8),
                          Text(StringsManger.book_club.tr())
                        ],
                      ),
                    ),),
                    Tab(child: Container(
                      padding:  EdgeInsets.all( 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManger.lightPrimary
                          ),
                          borderRadius: BorderRadius.circular(46)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsManger.sport_event,colorFilter: ColorFilter.mode(
                              selectedIndex==1
                                  ?Colors.white
                                  :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                              BlendMode.srcIn),
                            height: 24,width: 24,),
                          Gap(8),
                          Text(StringsManger.sport.tr())
                        ],
                      ),
                    ),),
                    Tab(child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:ColorManger.lightPrimary
                          ),
                          borderRadius: BorderRadius.circular(46)
                      ),
                      padding: EdgeInsets.all( 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsManger.cake_event,colorFilter: ColorFilter.mode(
                              selectedIndex==2
                                  ?Colors.white
                                  :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                              BlendMode.srcIn),
                            height: 24,width: 24,),
                          Gap(8),
                          Text(StringsManger.birthday.tr())
                        ],
                      ),
                    ),),



                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
