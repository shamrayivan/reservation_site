import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reservation_site/dio/dio.dart';
import 'package:reservation_site/ui/screens/reservation_screen/reservation_screen.dart';

void main() {
  DioManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Iguana',
        supportedLocales: const [Locale('ru', 'RU')],
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            secondaryHeaderColor: Colors.black,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            fontFamily: 'PosteRetro'),
        home: ReservationScreen());
  }
}
