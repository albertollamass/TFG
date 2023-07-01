import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/view/log_register.dart';

class forgottenPassword extends StatefulWidget {
  const forgottenPassword({super.key});

  @override
  State<forgottenPassword> createState() => _forgottenPasswordState();
}

class _forgottenPasswordState extends State<forgottenPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("CONTRASEÑA OLVIDADA",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
      body: Center(
          child: Container(
        height: 780,
        width: 370,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffffffff),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text(
            "Por favor, introduce tu correo electrónico",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Correo electronico'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: resetPasswd,
            style: ElevatedButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                backgroundColor: const Color.fromARGB(255, 67, 159, 162),
                padding: const EdgeInsets.fromLTRB(90.0, 16.0, 90.0, 16.0)),
            child: const Center(child: Text("ENVIAR CORREO")),
          ),
        ]),
      )),
      backgroundColor: const Color(0xff2B4EA1),
    );
  }

  Future resetPasswd() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      const snackBar = SnackBar(
        content: Text('Email de cambio de contraseña enviado correctamente'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } on FirebaseException catch (e) {            
      final snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }
}
