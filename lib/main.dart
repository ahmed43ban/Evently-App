import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/app_style.dart';
import 'package:evently/core/prefshelper.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/providers/location_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/create_event/screen/creat_event_screen.dart';
import 'package:evently/ui/event_details/screen/event_details_screen.dart';
import 'package:evently/ui/event_location/screen/event_location_screen.dart';
import 'package:evently/ui/forgetPassword_screen/Screen/forgetPassword_screen.dart';
import 'package:evently/ui/home_screen/screen/home_screen.dart';
import 'package:evently/ui/login_screen/screen/login_screen.dart';
import 'package:evently/ui/onboarding/screen/onBoarding_screen.dart';
import 'package:evently/ui/register_screen/screen/register_screen.dart';
import 'package:evently/ui/start_screen/screen/start_screen.dart';
import 'package:evently/ui/update_event/screen/update_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..initTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
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
        StartScreen.routName: (_) => StartScreen(),
        OnboardingScreen.routName: (_) => OnboardingScreen(),
        RegisterScreen.routName: (_) => RegisterScreen(),
        LoginScreen.routName: (_) => LoginScreen(),
        ForgetPasswordScreen.routName: (_) => ForgetPasswordScreen(),
        HomeScreen.routeName: (_) => ChangeNotifierProvider(
              create: (context) => UserProvider()..getUser(),
              child: HomeScreen(),
            ),
        EventLocationScreen.routeName: (_) => EventLocationScreen(),
        CreateEventScreen.routeName: (_) => CreateEventScreen(),
        EventDetailsScreen.routeName: (_) => EventDetailsScreen(),
        UpdateEventScreen.routeName: (_)=>UpdateEventScreen()
      },
      initialRoute: PrefHelper.getOnboarding()
          ? FirebaseAuth.instance.currentUser == null
              ? LoginScreen.routName
              : HomeScreen.routeName
          : StartScreen.routName,
    );
  }
}
