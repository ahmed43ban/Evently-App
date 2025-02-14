import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringsManger.welcome_back.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            StringsManger.const_p_name.tr(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (themeProvider.currentTheme ==
                                    ThemeMode.dark) {
                                  themeProvider.changeTheme(ThemeMode.light);
                                } else {
                                  themeProvider.changeTheme(ThemeMode.dark);
                                }
                              });
                            },
                            child: SvgPicture.asset(
                              themeProvider.currentTheme == ThemeMode.dark
                                  ? AssetsManger.moonIcon
                                  : AssetsManger.sunIcon,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              height: 30,
                              width: 30,
                            )),
                        Gap(16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            setState(() {
                              if (context.locale.languageCode == 'ar') {
                                context.setLocale(Locale('en'));
                              } else {
                                context.setLocale(Locale('ar'));
                              }
                            });
                          },
                          child: Text(
                            StringsManger.lang_code.tr(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Gap(8),
                Row(
                  children: [
                    SvgPicture.asset(AssetsManger.MapUnSelected),
                    Text(
                      StringsManger.const_location.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                TabBar(
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {});
                    },
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(46),
                    ),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerHeight: 0,
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(46)),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.all_event,
                                colorFilter: ColorFilter.mode(
                                    selectedIndex == 0
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixedVariant
                                        : Colors.white,
                                    BlendMode.srcIn),
                                height: 24,
                                width: 24,
                              ),
                              Gap(8),
                              Text(StringsManger.all.tr())
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(46)),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.sport_event,
                                colorFilter: ColorFilter.mode(
                                    selectedIndex == 1
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixedVariant
                                        : Colors.white,
                                    BlendMode.srcIn),
                                height: 24,
                                width: 24,
                              ),
                              Gap(8),
                              Text(StringsManger.sport.tr())
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(46)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.cake_event,
                                colorFilter: ColorFilter.mode(
                                    selectedIndex == 2
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixedVariant
                                        : Colors.white,
                                    BlendMode.srcIn),
                                height: 24,
                                width: 24,
                              ),
                              Gap(8),
                              Text(StringsManger.birthday.tr())
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(46)),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManger.book_event,
                                colorFilter: ColorFilter.mode(
                                    selectedIndex == 3
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimaryFixedVariant
                                        : Colors.white,
                                    BlendMode.srcIn),
                                height: 24,
                                width: 24,
                              ),
                              Gap(8),
                              Text(StringsManger.book_club.tr())
                            ],
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ListView.separated(
                        itemBuilder: (context, index) => EventItem(),
                        separatorBuilder: (context, index) => Gap(16),
                        itemCount: 10),
                    ListView.separated(
                        itemBuilder: (context, index) => EventItem(),
                        separatorBuilder: (context, index) => Gap(16),
                        itemCount: 10),
                    ListView.separated(
                        itemBuilder: (context, index) => EventItem(),
                        separatorBuilder: (context, index) => Gap(16),
                        itemCount: 10),
                    ListView.separated(
                        itemBuilder: (context, index) => EventItem(),
                        separatorBuilder: (context, index) => Gap(16),
                        itemCount: 10),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
