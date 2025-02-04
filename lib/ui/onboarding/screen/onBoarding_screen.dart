import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/login_screen/screen/login_screen.dart';
import 'package:evently/ui/onboarding/widget/onPage_widget.dart';
import 'package:evently/ui/register_screen/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  static String routName ="onboarding";
   OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage=0;

  PageController controller=PageController();
/*  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final page = controller.page?.toInt() ?? 0;
      if (page != currentPage) {
        setState(() {
          currentPage = page;
        });
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManger.logo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value){
                  currentPage=value;
                  setState(() {
                  });
                },
                controller: controller,
                children: [
                  OnpageWidget(path:AssetsManger.hotTrending,
                      title:StringsManger.titleOnboarding1,
                      desc:StringsManger.descOnboarding1),
                  OnpageWidget(path:themeProvider.currentTheme==ThemeMode.light
                      ?AssetsManger.beingCreative2
                      :AssetsManger.beingCreativeDark2,
                      title:StringsManger.titleOnboarding1,
                      desc:StringsManger.descOnboarding1),
                  OnpageWidget(path:themeProvider.currentTheme==ThemeMode.light
                      ?AssetsManger.beingCreative3
                      :AssetsManger.beingCreativeDark3,
                      title:StringsManger.titleOnboarding1,
                      desc:StringsManger.descOnboarding1),
                ],
                ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentPage!=0?
                    IconButton(
                        onPressed: (){
                      controller.previousPage(duration: Duration(milliseconds: 100),
                          curve: Curves.decelerate);
                    }, icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                        child: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.primary,)))
                        :Text(""),
                    IconButton(
                        onPressed: (){
                          if(currentPage<2) {
                            controller.nextPage(duration: Duration(
                                milliseconds: 100),
                                curve: Curves.decelerate);
                          }else{
                              Navigator.pushReplacementNamed(context, LoginScreen.routName);

                          }
                    },
                        icon: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary
                            )
                        ),
                        child: Icon(Icons.arrow_forward,color:Theme.of(context).colorScheme.primary,))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                    List.generate(3, (index){
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: AnimatedContainer(duration: Duration(milliseconds: 100),
                            height:9,
                          width:currentPage==index?20:10 ,
                          decoration: BoxDecoration(
                            color:currentPage==index?Theme.of(context).colorScheme.primary
                                :Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(5)
                          ),),
                      );
                    })
                  ,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
