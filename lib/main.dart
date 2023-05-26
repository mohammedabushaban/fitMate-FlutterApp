import 'package:fitmate/Form/add_screen.dart';
import 'package:fitmate/controller/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';
import 'model/db_helper.dart';
import 'onboarding/OnboardingScreen.dart';
import 'profile/profile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(Directionality(
    textDirection: TextDirection.rtl,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbController>(
      create: (context) => DbController(),
      child: MaterialApp(
        title: 'Fitness App',
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('ar', ''), // Arabic
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device language is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          // If the current device language is not supported, use the first locale
          // from the supported locales list
          return supportedLocales.first;
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/onboarding',
        routes: {
          '/profile': (context) => ProfileScreen(),
          '/onboarding': (context) => OnboardingScreen(),
          '/home': (context) => HomeScreen(),
          '/add': (context) => AddScreen(),
        },
      ),
    );
  }
}
