import 'package:flutter/material.dart';
import 'package:football_club_app/view/log_register.dart';

class forgottenPassword extends StatefulWidget {
  const forgottenPassword({super.key});

  @override
  State<forgottenPassword> createState() => _forgottenPasswordState();
}

class _forgottenPasswordState extends State<forgottenPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, elevation: 0, title: Text("CONTRASEÑA OLVIDADA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
      body: Center(
        child: Container (
          height: 780,
          width: 370,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Por favor, introduce tu correo electrónico", style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(hintText: 'Correo electronico'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: (() => {
                  Navigator.pop(
                    context
                  )
                }), 
                child: Center(child: Text("ENVIAR CORREO")),
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), backgroundColor: Color.fromARGB(255, 67, 159, 162), padding: EdgeInsets.fromLTRB(90.0,16.0,90.0,16.0)),             
                
              ),

          ]),
        )
      ),
      backgroundColor: const Color(0xff2B4EA1),
    );
  }
}