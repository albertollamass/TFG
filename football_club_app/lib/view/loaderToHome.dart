import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loaderHome extends StatefulWidget {
  const loaderHome({super.key});

  @override
  State<loaderHome> createState() => _loaderHomeState();
}

class _loaderHomeState extends State<loaderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B4EA1),
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
          duration: Duration(seconds: 4),
        )
      ),
    );
  }
}