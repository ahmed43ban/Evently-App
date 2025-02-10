import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/create_event/screen/creat_event_screen.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home_screen/tabs/love_tab/love_tab.dart';
import 'package:evently/ui/home_screen/tabs/map_tab/map_tab.dart';
import 'package:evently/ui/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget>tabs=[
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, CreateEventScreen.routeName);
          },
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 5
          )
        ),
        child: Icon(Icons.add,size: 40,) ,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
          onTap: (index){
          selectedIndex=index;
          setState(() {

          });
          },
          items: [
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.homeUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.homeSelected),
                label: StringsManger.home.tr()),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.MapUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.MapSelected),
                label: StringsManger.map.tr()),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.loveUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.loveSelected),
                label: StringsManger.love.tr()),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.profileUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.profileSelected),
                label: StringsManger.profile.tr()),
          ]),
      body: tabs[selectedIndex]
    );
  }
}
