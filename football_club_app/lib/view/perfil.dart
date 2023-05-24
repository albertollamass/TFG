import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff2B4EA1),
            Colors.white,
          ],
        )
        )
        ),
      Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          "SOCIO",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
      )
    ),
    ]
    );
  }
}