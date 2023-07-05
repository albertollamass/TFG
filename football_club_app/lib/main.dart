import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/view/home.dart';
import 'model/socio.dart';
import 'view/log_register.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // Disable persistence on web platforms. Must be called on initialization:
//   final auth = FirebaseAuth.instanceFor(
//       app: Firebase.app(), persistence: Persistence.NONE);
// // To change it after initialization, use `setPersistence()`:
//   await auth.setPersistence(Persistence.LOCAL);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<Socio> initState() async {
  //   return await obtenerSocio("KOJoeFef7JFiYBrEYuB4");
  // }

  // This widget is the root of your application.
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

    return MaterialApp(
      title: 'Football App',
      theme: ThemeData(
        primaryColor: const Color(0xff2B4EA1),
        primarySwatch: MaterialColor(0xff2B4EA1, color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogRegister(),
    );
  }
}
