import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/start_screen/widget/language_toggle.dart';
import 'package:evently/ui/start_screen/widget/theme_toggle.dart';
import 'package:evently/ui/start_screen/widget/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class StartScreen extends StatelessWidget {
  static const String routName= "start";
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManger.logo),
      ),
      body: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(vertical: 28,horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(AssetsManger.beingCreative)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(StringsManger.personalize1.tr(),style:Theme.of(context).textTheme.titleMedium,),
                Gap(28),
                Text(StringsManger.startText.tr(),style:Theme.of(context).textTheme.titleSmall,),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(StringsManger.language.tr(),style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),),
                    LanguageToggle(),
                  ],
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(StringsManger.theme.tr(),style:
                    Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),),
                    ThemeToggle(),
                  ],
                ),
                Gap(28),
                CustomButton(title: StringsManger.letsStart.tr(),onPressed: (){},)
              ],
            )
          ],
        ),
      ),
    );
  }
}
