// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:football_club_app/view/forgotten_password.dart';
import 'package:football_club_app/view/home.dart';
import 'package:football_club_app/view/loaderToHome.dart';

import '../model/socio.dart';

class LogIn extends StatefulWidget {
  final bool credencialesErroneas;
  const LogIn({
    Key? key,
    this.credencialesErroneas = false,
  }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Socio socio = Socio("Pablo", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50);
  bool? recordarCredenciales = false ;
  bool isLoading = false;
  final ButtonStyle styleInic =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), backgroundColor: const Color.fromARGB(255, 67, 159, 162), padding: const EdgeInsets.fromLTRB(90.0,16.0,90.0,16.0));
  TextEditingController correoController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
    

  @override
  Widget build(BuildContext context) => isLoading 
  ? const loaderHome()
  : Scaffold(
      body: Center(
        child: Container(
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
              TextFormField(
                controller: correoController,
                validator: (value) {
                  if (value != socio.email){                    
                    return "Introduce el correo electronico";
                  } else {
                    return "okey";
                  }
                },
                decoration: const InputDecoration(icon: Icon(Icons.person),hintText: 'Correo electrónico'),
              ),
              TextFormField(
                controller: passwdController,
                validator: (value) {
                  if (value!.isNotEmpty){
                    print("entro");                    
                    return "Contraseña Incorrecta";
                  }
                  return "okey";
                },
                decoration: const InputDecoration(icon: Icon(Icons.password_rounded),hintText: 'Contraseña'),
              ),
              CheckboxListTile(
                title: const Text("Recordar credenciales"),
                controlAffinity: ListTileControlAffinity.leading,
                value: recordarCredenciales, 
                activeColor: Colors.blueGrey,
                tristate: false,
                onChanged: (newBool) {
                  setState(() {
                    recordarCredenciales = newBool;
                  });
                },
              ),
              widget.credencialesErroneas ? const Text("Email o contraseña incorrecta",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.redAccent), textAlign: TextAlign.center,)
              : const Text(""),
              ElevatedButton(
                onPressed: (() async => {
                  if (passwdController.text != socio.password || correoController.text != socio.email){
                    setState(() => isLoading = true) ,
                    await Future.delayed(const Duration(seconds: 2)),
                    setState(() => isLoading = false),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LogIn(credencialesErroneas: true,)),                    
                    )
                  } else {
                    setState(() => isLoading = true) ,
                    await Future.delayed(const Duration(seconds: 4)),
                    setState(() => isLoading = false),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(socio: socio,)),                    
                    )  
                  }                
                }),
                style: styleInic, 
                child: const Center(child: Text("INICIA SESIÓN")),
                
              ),
              ElevatedButton(
                onPressed: (() => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const forgottenPassword()),
                  )
                }),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent), 
                child: const Text("¿Contraseña olvidada?", style: TextStyle(fontSize: 15, color: Colors.grey)),
                
              ), 
            ]
          ), 
        ),
      ),
      backgroundColor: const Color(0xff2B4EA1),
      appBar: AppBar(
        title: const Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),"INICIAR SESIÓN"),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
