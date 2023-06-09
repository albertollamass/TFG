import 'package:flutter/material.dart';
import 'package:football_club_app/view/notificacion_lectura.dart';
import 'package:football_club_app/view/resumen.dart';

import '../model/notificacion.dart';

class Notificaciones extends StatefulWidget {
  final bool esAdmin;
  const Notificaciones({Key? key, required this.esAdmin})
      : super(key: key);

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
              width: 10,
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
            notificaciones[i].leida
                ? Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xff0AD905),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "LEIDA",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )
                : Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xffC10707),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "NO LEIDA",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LecturaNotificacion(notificacion: notificaciones[i])),
          );
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
                )
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.esAdmin ? SizedBox(          
          width: 70,
          height: 70,
          child: FittedBox(
            alignment: Alignment.center,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 130, 167, 254),
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notificaciones(esAdmin: true,)),                    
                  );
              }),
              child: const Icon(
                Icons.add,
                size: 40,
              ),
            ),
          ),
        ) : const SizedBox()
        
    );
  }
}
