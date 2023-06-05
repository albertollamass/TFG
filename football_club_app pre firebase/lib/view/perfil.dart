import 'package:flutter/material.dart';
import 'package:football_club_app/view/log_register.dart';
import 'package:football_club_app/view/notificaciones.dart';

import 'datos_personales.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String usuario = "Pablo Perez";
  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 130,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Bienvenido $usuario!",
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                  color: Color.fromARGB(255, 72, 72, 75)),
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
                                      MaterialPageRoute(builder: (context) => DatosPersonales()),
                                    );
                          },
                        ),
                        const SizedBox(height: 20,),
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
                                  color: Color.fromARGB(255, 72, 72, 75)),
                            ),
                            SizedBox(
                              width: 109,
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
                                      MaterialPageRoute(builder: (context) => Notificaciones()),
                                    );
                          },
                        ),
                        const SizedBox(height: 20,),
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
                                  color: Color.fromARGB(255, 72, 72, 75)),
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
                            print("Tapped on STATS");
                          },
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 60,),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                                  color: Color.fromARGB(255, 72, 72, 75)),
                            ),
                            SizedBox(
                              width: 230,
                            ),
                            Text(                              
                              "0.1.0",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 72, 72, 75)),
                            ),                          
                          ]),

                        const SizedBox(height: 20,),
                        InkWell(
                          child: Row(children: const [                                                        
                            Text(
                              "Cerrar sesión",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffD01E1E),)
                            ),
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
                              content: const Text("¿Estás seguro de que quieres cerrar sesión?"), 
                              actions: [
                                TextButton(
                                  child: const Text("Cerrar sesión"),
                                  onPressed: () => {
                                    Navigator.push(
                                      context,                                      
                                      MaterialPageRoute(builder: (context) => LogRegister()),
                                    )
                                  },                                   
                                ),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => {Navigator.pop(context)},                                  
                                )
                              ],


                            );
                            showDialog(context: context, builder: (BuildContext context) {
                              return alert;
                            });
                          },
                        ),
                        const SizedBox(height: 10,),                        
                      ],
                    )
                ),
                 const SizedBox(height: 20,),                        
              ],
            ),
      ))),
    ]);
  }
}
