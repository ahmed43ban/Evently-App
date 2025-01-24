import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  int currentValue=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp){
      if(context.locale.languageCode=="ar"){
        currentValue=1;
      }else{
        currentValue=0;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return  AnimatedToggleSwitch<int>.rolling(
      current: currentValue,
      values: [0, 1],
      onChanged: (newValue){
        setState(() {
          currentValue=newValue;
          if(currentValue==0){
            context.setLocale(Locale("en"));
          }else{
            context.setLocale(Locale("ar"));
          }
        });
      },
      iconOpacity: 1,
      style: ToggleStyle(
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,

      ),
      iconList: [
        SvgPicture.asset(AssetsManger.englishLan,
          height: 30,
          width: 30,
        ),
        SvgPicture.asset(AssetsManger.arabicLan,
          height: 30,
          width: 30,
        ),
      ],
      // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
      // many more parameters available
    );
  }
}
