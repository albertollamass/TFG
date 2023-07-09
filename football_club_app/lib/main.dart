import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/log_register.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  
    options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: const Color.fromRGBO(43, 78, 161, .1),
      100: const Color.fromRGBO(43, 78, 161, .2),
      200: const Color.fromRGBO(43, 78, 161, .3),
      300: const Color.fromRGBO(43, 78, 161, .4),
      400: const Color.fromRGBO(43, 78, 161, .5),
      500: const Color.fromRGBO(43, 78, 161, .6),
      600: const Color.fromRGBO(43, 78, 161, .7),
      700: const Color.fromRGBO(43, 78, 161, .8),
      800: const Color.fromRGBO(43, 78, 161, .9),
      900: const Color.fromRGBO(43, 78, 161, 1),
    };
    FirebaseAuth.instance.signOut();

    return MaterialApp(
      title: 'Football App',
      theme: ThemeData(
        primaryColor: const Color(0xff2B4EA1),
        primarySwatch: MaterialColor(0xff2B4EA1, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogRegister(),
      builder: (context, child) {
          final mediaQueryData = MediaQuery.of(context);
          final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            child: child!,
          );
        },
    );
  }
}
