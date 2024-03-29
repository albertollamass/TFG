import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/view/admin_crear_usuario.dart';
import 'package:football_club_app/view/home.dart';
import 'package:football_club_app/view/log_in.dart';

class Crear extends StatelessWidget {
  const Crear({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasError){
            return const Center(child: Text("Hubo un error!"),);
          } else if (snapshot.hasData){
            return const CrearUsuario();          
          } else {
            return const Home();
          }
        },
      ),
    );
  }
}