import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/app_style.dart';
import 'package:evently/core/prefshelper.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/start_screen/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
          create: (context)=>ThemeProvider()..initTheme(),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      routes: {
        StartScreen.routName:(_)=>StartScreen(),
      },
      initialRoute: StartScreen.routName,
    );
  }
}


