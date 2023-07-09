import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/view/crear.dart';

import '../model/socio.dart';
import 'admin_crear_usuario.dart';
import 'datos_personales.dart';

class AdminSolicitudes extends StatefulWidget {
  const AdminSolicitudes({super.key});

  @override
  State<AdminSolicitudes> createState() => _AdminSolicitudesState();
}

class _AdminSolicitudesState extends State<AdminSolicitudes> {
  @override
  Widget build(BuildContext context) {
    final usuarioActivo = FirebaseAuth.instance.currentUser!.email;
    Widget buildSocio(Socio socio) {
      return Row(
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
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DatosPersonales(
                            socio: socio,
                            esSolicitud: true,
                          )),
                );
              },
              child: Text(
                "${socio.nombre} ${socio.apellidos}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          InkWell(
            child: const SizedBox(
              width: 40,
              child: Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            onTap: () {
              print(socio.email! + "del");
              final docSol = FirebaseFirestore.instance
                  .collection('solicitudes')
                  .doc(socio.email.toString());
              docSol.delete();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminSolicitudes()),
              );
              const snackBar = SnackBar(
                content: Text('Usuario rechazado correctamente'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 20,
              child: Icon(Icons.check_circle_outline, color: Colors.green),
            ),
            onTap: () {
              crearSocio(
                  socio.nombre.toString(),
                  socio.apellidos.toString(),
                  socio.alias,
                  socio.email.toString(),
                  socio.password.toString(),
                  socio.telefono.toString(),
                  false,
                  usuarioActivo);
              final docSocio = FirebaseFirestore.instance
                  .collection('solicitudes')
                  .doc(socio.email.toString());
              docSocio.delete();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminSolicitudes()),
              );

              const snackBar = SnackBar(
                content: Text('Usuario aceptado correctamente'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "SOLICITUDES SOCIOS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color(0xff2B4EA1),
        body: StreamBuilder<List<Socio>>(
          stream: leerSolicitudes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final socios = snapshot.data!;
              if (socios.isEmpty) {
                return Center(
                    child: Container(
                        height: 780,
                        width: 370,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffffffff),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.person_pin_outlined,
                                size: 60,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "NO HAY SOLICITUDES",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ])));
              } else {
                return Center(
                    child: Container(
                  height: 780,
                  width: 370,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffffff),
                  ),
                  child: ListView(
                    children: socios.map(buildSocio).toList(),
                  ),
                ));
              }
            } else {
              return const Text("error");
            }
          },
        ));
  }
}
