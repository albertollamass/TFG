import 'package:flutter/material.dart';
import 'package:football_club_app/view/resumen.dart';

import '../model/notificacion.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({super.key});

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  List<Notificacion> notificaciones = [
    Notificacion("Prueba de descripción", "Juan", DateTime.now()),
    Notificacion("Prueba de descripción", "Pepe", DateTime.now())
  ];
  // Notificacion n1 = Notificacion("Prueba de descripción", "Juan", DateTime.now());
  // Notificacion n2 = Notificacion("Prueba de descripción", "Pepe", DateTime.now());
  @override
  Widget build(BuildContext context) {
    List<Widget> notificacionesW = [];

    for (int i = 0; i < notificaciones.length; i++) {
      notificacionesW.add(InkWell(
        child: Row(
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
            const SizedBox(
              width: 20,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${notificaciones[i].emisor}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                weekdayToString(notificaciones[i].fechaEnvio?.weekday) +
                    " " +
                    notificaciones[i].fechaEnvio?.day.toString() +
                    " " +
                    monthToString(notificaciones[i].fechaEnvio?.month),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ]),
            const SizedBox(
              width: 30,
            ),
            Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: const Color(0xffC10707),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text(
                "NO LEIDA",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
        onTap: () {
          
        },
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "NOTIFICACIONES",
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
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffffffff),
                ),
                child: ListView(
                  children: notificacionesW,
                ))));
  }
}
