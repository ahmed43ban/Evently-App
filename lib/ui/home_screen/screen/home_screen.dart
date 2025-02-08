import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24)
          )
        ),
        toolbarHeight: 174,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back ✨",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),),
            Text("John Safwat",style: Theme.of(context).textTheme.headlineMedium,),
            Gap(8),
            Row(
              children: [
                SvgPicture.asset(AssetsManger.MapUnSelected),
                Text("Cairo , Egypt",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                ),)
              ],
            )
          ],
        ),
      ),
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
                label: "Home"),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.MapUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.MapSelected),
                label: "Map"),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.loveUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.loveSelected),
                label: "Love"),
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManger.profileUnSelected) ,
                activeIcon: SvgPicture.asset(AssetsManger.profileSelected),
                label: "Profile"),
          ]),
      body: tabs[selectedIndex]
    );
  }
}
