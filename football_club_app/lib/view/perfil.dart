import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/view/admin_pagos.dart';
import 'package:football_club_app/view/admin_partidos.dart';
import 'package:football_club_app/view/admin_solicitudes.dart';
import 'package:football_club_app/view/admin_usuarios.dart';
import 'package:football_club_app/view/log_register.dart';
import 'package:football_club_app/view/notificaciones.dart';
import 'package:football_club_app/view/tus_estadisticas.dart';

import '../model/socio.dart';
import 'datos_personales.dart';

class Perfil extends StatefulWidget {
  final Socio socio;
  const Perfil({Key? key, required this.socio}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final usuarioActivo = FirebaseAuth.instance.currentUser?.email;

    return Stack(children: [
      Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff2B4EA1),
          Colors.white,
        ],
      ))),
      Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "SOCIO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Column(children: [
              FutureBuilder<Socio?>(
                future: leerSocio(usuarioActivo.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    print("en");
                    if (user == null) {
                      return const Center(
                        child: Text("nono"),
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 2, color: Colors.white)),
                            child: const Icon(
                              Icons.person_rounded,
                              size: 130,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Bienvenido ${user.nombre}!",
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 50),
                          Container(
                            width: 380,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffC1C2C6),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: const Text(
                              "CUENTA",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Container(
                              width: 380,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffE0DEE4),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    child: Row(children: const [
                                      Icon(
                                        Icons.person_rounded,
                                        size: 45,
                                        color: Color(0xff94949C),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Datos personales",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 72, 72, 75)),
                                      ),
                                      SizedBox(
                                        width: 80,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: Color(0xff94949C),
                                      )
                                    ]),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DatosPersonales(
                                                  socio: user,
                                                  esSolicitud: false,
                                                )),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Row(children: const [
                                      Icon(
                                        Icons.notifications,
                                        size: 45,
                                        color: Color(0xff94949C),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Notificaciones",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 72, 72, 75)),
                                      ),
                                      SizedBox(
                                        width: 107,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: Color(0xff94949C),
                                      )
                                    ]),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Notificaciones(
                                                  esAdmin: user.esAdmin!,
                                                  emailSocios: [],
                                                  selectedItems: [],
                                                )),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Row(children: const [
                                      Icon(
                                        Icons.sports_soccer,
                                        size: 45,
                                        color: Color(0xff94949C),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Modificar estadísticas",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 72, 72, 75)),
                                      ),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: Color(0xff94949C),
                                      )
                                    ]),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TusEstadisticas()),
                                      );
                                    },
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 60,
                          ),

                          user.esAdmin!
                              ? Container(
                                  width: 380,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffC1C2C6),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  child: const Text(
                                    "ADMIN",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )
                              : const Text(""),

                          user.esAdmin!
                              ? Container(
                                  width: 380,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE0DEE4),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: Row(children: const [
                                          Icon(
                                            Icons.person_pin_rounded,
                                            size: 45,
                                            color: Color(0xff94949C),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Solicitudes",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 72, 72, 75)),
                                          ),
                                          SizedBox(
                                            width: 135,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                            color: Color(0xff94949C),
                                          )
                                        ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminSolicitudes()),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        child: Row(children: const [
                                          Icon(
                                            Icons.people,
                                            size: 45,
                                            color: Color(0xff94949C),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Socios",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 72, 72, 75)),
                                          ),
                                          SizedBox(
                                            width: 175,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                            color: Color(0xff94949C),
                                          )
                                        ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminUsuarios()),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        child: Row(children: const [
                                          Icon(
                                            Icons.sports_soccer,
                                            size: 45,
                                            color: Color(0xff94949C),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Partidos",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 72, 72, 75)),
                                          ),
                                          SizedBox(
                                            width: 160,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                            color: Color(0xff94949C),
                                          )
                                        ]),
                                        onTap: () {
                                          Equipo equipo1 = Equipo(
                                              color: "negro",
                                              fechaEquipo: DateTime(2023, 6, 30),
                                              jugadores: [
                                                "Antonio@gmail.com",
                                                "Joaquin@gmail.com",
                                                "M.Pardo@gmail.com",
                                                "Sergio@gmail.com",
                                                "Francis@gmail.com",
                                                "Victor@gmail.com"
                                              ]);
                                          Equipo equipo2 = Equipo(
                                              color: "blanco",
                                              fechaEquipo: DateTime(2023, 6, 30),
                                              jugadores: [
                                                "rafa@gmail.com",
                                                "jose@gmail.com",
                                                "Juanjo@gmail.com",
                                                "Nene@gmail.com",
                                                "Sam@gmail.com",
                                                "Joseles@gmail.com",
                                              ]);
                                          //crearEquipo([]);
                                          //crearPartido(equipo1.fechaEquipo,
                                              //equipo1, equipo2);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminPartidos()),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        child: Row(children: const [
                                          Icon(
                                            Icons.payment,
                                            size: 45,
                                            color: Color(0xff94949C),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Transacciones",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 72, 72, 75)),
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                            color: Color(0xff94949C),
                                          )
                                        ]),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminPagos()),
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                              : const Text(""),
                          user.esAdmin!
                              ? const SizedBox(
                                  height: 60,
                                )
                              : const Text(""),

                          //APP
                          Container(
                            width: 380,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xffC1C2C6),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: const Text(
                              "APP",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),

                          Container(
                              width: 380,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffE0DEE4),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Row(children: const [
                                    Text(
                                      "Versión",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 72, 72, 75)),
                                    ),
                                    SizedBox(
                                      width: 220,
                                    ),
                                    Text(
                                      "0.1.0",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 72, 72, 75)),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Row(children: const [
                                      Text("Cerrar sesión",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xffD01E1E),
                                          )),
                                      SizedBox(
                                        width: 180,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: Color(0xffD01E1E),
                                      )
                                    ]),
                                    onTap: () {
                                      AlertDialog alert = AlertDialog(
                                        title: const Text("Cerrar sesión"),
                                        content: const Text(
                                            "¿Estás seguro de que quieres cerrar sesión?"),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cerrar sesión",
                                              style: TextStyle(
                                                  color: Color(0xffD01E1E)),
                                            ),
                                            onPressed: () => {
                                              FirebaseAuth.instance.signOut(),
                                              Navigator.pop(context),
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Cancelar"),
                                            onPressed: () =>
                                                {Navigator.pop(context)},
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }
                  } else {
                    print(snapshot.error.toString());
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ]),
          ))),
    ]);
  }
}
