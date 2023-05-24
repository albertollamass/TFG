import 'package:flutter/material.dart';
import 'package:football_club_app/view/forgotten_password.dart';
import 'package:football_club_app/view/home.dart';
import 'package:football_club_app/view/loaderToHome.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  bool? recordarCredenciales = false ;
  bool isLoading = false;
  final ButtonStyle styleInic =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), backgroundColor: Color.fromARGB(255, 67, 159, 162), padding: EdgeInsets.fromLTRB(90.0,16.0,90.0,16.0));

  @override
  Widget build(BuildContext context) => isLoading 
  ? const loaderHome()
  : Scaffold(
      body: Center(
        child: Container(
          height: 780,
          width: 370,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.person),hintText: 'Correo electrónico'),
              ),
              TextFormField(
                decoration: InputDecoration(icon: Icon(Icons.password_rounded),hintText: 'Contraseña'),
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
              ElevatedButton(
                onPressed: (() async => {
                  setState(() => isLoading = true) ,
                  await Future.delayed(Duration(seconds: 4)),
                  setState(() => isLoading = false),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    
                  )
                  
                }), 
                child: Center(child: Text("INICIA SESIÓN")),
                style: styleInic,
                
              ),
              ElevatedButton(
                onPressed: (() => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => forgottenPassword()),
                  )
                }), 
                child: Text("¿Contraseña olvidada?", style: TextStyle(fontSize: 15, color: Colors.grey)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                
              ), 
            ]
          ), 
        ),
      ),
      backgroundColor: Color(0xff2B4EA1),
      appBar: AppBar(
        title: Text(style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),"INICIAR SESIÓN"),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
