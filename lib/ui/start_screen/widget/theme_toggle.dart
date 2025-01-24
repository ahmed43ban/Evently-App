import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/app_style.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int currentValue=0;
  @override
  Widget build(BuildContext context) {
    return  AnimatedToggleSwitch<int>.rolling(
      current: currentValue,
      values: [0, 1],
      onChanged: (newValue){
        setState(() {
          currentValue=newValue;
          if(currentValue==0){
            AppStyle.isDark=false;
          }else{
            AppStyle.isDark=true;
          }
        });
      },
      iconOpacity: 1,
      style: ToggleStyle(
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,

      ),
      iconList: [
        SvgPicture.asset(AssetsManger.sunIcon,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
              currentValue==0?Theme.of(context).colorScheme.onPrimary
                  :Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
        ),
        SvgPicture.asset(AssetsManger.moonIcon,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
              currentValue==1?Theme.of(context).colorScheme.onPrimary
                  :Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
        ),
      ],
      // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
      // many more parameters available
    );
  }
}
