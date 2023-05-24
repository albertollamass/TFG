import 'package:flutter/material.dart';
import 'package:football_club_app/view/home.dart';
import 'view/log_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color ={
    50:Color.fromRGBO(43, 78, 161, .1),
    100:Color.fromRGBO(43, 78, 161, .2),
    200:Color.fromRGBO(43, 78, 161, .3),
    300:Color.fromRGBO(43, 78, 161, .4),
    400:Color.fromRGBO(43, 78, 161, .5),
    500:Color.fromRGBO(43, 78, 161, .6),
    600:Color.fromRGBO(43, 78, 161, .7),
    700:Color.fromRGBO(43, 78, 161, .8),
    800:Color.fromRGBO(43, 78, 161, .9),
    900:Color.fromRGBO(43, 78, 161, 1),};

    return MaterialApp(
      title: 'Football App',
      theme: ThemeData(
        primaryColor: const Color(0xff2B4EA1),
        primarySwatch: MaterialColor(0xff2B4EA1, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

