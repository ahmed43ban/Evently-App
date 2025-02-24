import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home_screen/tabs/profile_tab/widget/languagesheet.dart';
import 'package:evently/ui/home_screen/tabs/profile_tab/widget/themesheet.dart';
import 'package:evently/ui/login_screen/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(24),
            ),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                height: 124,
                width: 124,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(1000),
                      bottomEnd: Radius.circular(1000),
                      bottomStart: Radius.circular(1000),
                    ),
                    color: Colors.white),
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user?.name ?? "No Name",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Gap(8),
                    Text(
                      FirebaseAuth.instance.currentUser?.email ?? "No User",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManger.language,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Gap(16),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => LanguageSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorManger.lightPrimary)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.locale.languageCode == "ar"
                              ? StringsManger.language2
                              : StringsManger.language1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: ColorManger.lightPrimary,
                        )
                      ],
                    ),
                  ),
                ),
                Gap(16),
                Text(
                  StringsManger.theme.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Gap(16),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ThemeSheet(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorManger.lightPrimary)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeProvider.currentTheme == ThemeMode.dark
                              ? StringsManger.theme2.tr()
                              : StringsManger.theme1.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: ColorManger.lightPrimary,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      logOutDialog(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        Gap(16),
                        Text(
                          StringsManger.log_out.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        )
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  logOutDialog(context) {
    DialogUtils.showMessageDialog(
        context: context,
        message: StringsManger.confirm_log_out.tr(),
        buttonTitle2: StringsManger.cancel.tr(),
        positiveBtnClick2: () {
          Navigator.pop(context);
        },
        buttonTitle: StringsManger.ok.tr(),
        positiveBtnClick: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.routName);
        });
  }
}
