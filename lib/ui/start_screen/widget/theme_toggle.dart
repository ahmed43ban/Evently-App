import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/prefshelper.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    currentValue = PrefHelper.getTheme() ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<int>.rolling(
      current: currentValue,
      values: [0, 1],
      onChanged: (newValue) {
        setState(() {
          currentValue = newValue;
          if (currentValue == 0) {
            themeProvider.changeTheme(ThemeMode.light);
          } else {
            themeProvider.changeTheme(ThemeMode.dark);
          }
        });
      },
      iconOpacity: 1,
      style: ToggleStyle(
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
      ),
      iconList: [
        SvgPicture.asset(
          AssetsManger.sunIcon,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
              currentValue == 0
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
        ),
        SvgPicture.asset(
          AssetsManger.moonIcon,
          height: 30,
          width: 30,
          colorFilter: ColorFilter.mode(
              currentValue == 1
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary,
              BlendMode.srcIn),
        ),
      ],
      // iconList: [...], you can use iconBuilder, customIconBuilder or iconList
      // many more parameters available
    );
  }
}
