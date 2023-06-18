import 'package:flutter/material.dart';
import 'package:football_club_app/view/perfil.dart';

import '../model/socio.dart';
import 'admin_crear_usuario.dart';
import 'datos_personales.dart';

class AdminUsuarios extends StatefulWidget {
  const AdminUsuarios({super.key});

  @override
  State<AdminUsuarios> createState() => _AdminUsuariosState();
}

class _AdminUsuariosState extends State<AdminUsuarios> {
  List<Socio> socios = [
    Socio("Pablo", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50, "Pablito"),
    Socio("Juan", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50, "Pablito"),
    Socio("Luis", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50, "Pablito"),
    Socio("Miguel", "Perez", "pabloperez@gmail.com", 611611611, "pablo0_", 50, "Pablito"),
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> sociosW = [];

    for (int i = 0; i < socios.length; i++) {
      sociosW.add(Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 2, color: Colors.white)),
            child: const Icon(
              Icons.person_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 190,
            child: Text(
              "${socios[i].nombre} ${socios[i].apellidos}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child:  const SizedBox(
              width: 40,
              child: Icon(Icons.edit),              
            ),
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DatosPersonales(socio: socios[i],)),
                  );              
            },
          ),
          InkWell(
            child:  const SizedBox(
              width: 20,
              child: Icon(Icons.delete),              
            ),
            onTap: () {  
              AlertDialog alert = AlertDialog(
                  title: const Text("Cerrar sesión"),
                  content:
                      const Text("¿Estás seguro de que quieres eliminar a este socio?"),
                  actions: [
                    TextButton(
                      child: const Text(
                        "Eliminar socio",
                        style: TextStyle(color: Color(0xffD01E1E)),
                      ),
                      onPressed: () => {
                      socios.removeWhere( (item) => item == socios[i]), 
                      Navigator.pop(context)                       
                      },
                    ),
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => {Navigator.pop(context)},
                    )
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    });            
            },
          ),          
        ],
      ));
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(          
          width: 70,
          height: 70,
          child: FittedBox(
            alignment: Alignment.center,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 130, 167, 254),
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrearUsuario()),                    
                  );
              }),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "SOCIOS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color(0xff2B4EA1),
        body: Center(
            child: Container(
          height: 780,
          width: 370,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
          ),
          child: ListView(
            children: sociosW,
          ),
        )));
  }
}
