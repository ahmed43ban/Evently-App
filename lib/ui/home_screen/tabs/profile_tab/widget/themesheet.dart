import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ThemeSheet extends StatelessWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 200,
      color: Colors.grey,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                themeProvider.currentTheme == ThemeMode.dark
                    ? StringsManger.theme2.tr()
                    : StringsManger.theme1.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Icon(
                Icons.check,
                size: 30,
                color: ColorManger.lightPrimary,
              )
            ],
          ),
          Gap(24),
          InkWell(
            onTap: () {
              if (themeProvider.currentTheme == ThemeMode.dark) {
                themeProvider.changeTheme(ThemeMode.light);
              } else {
                themeProvider.changeTheme(ThemeMode.dark);
              }
            },
            child: Text(
              themeProvider.currentTheme != ThemeMode.dark
                  ? StringsManger.theme2.tr()
                  : StringsManger.theme1.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        ],
      ),
    );
  }
}
