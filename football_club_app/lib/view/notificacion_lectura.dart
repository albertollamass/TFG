import 'package:flutter/material.dart';
import '../controller/controlador.dart';

import '../model/notificacion.dart';

class LecturaNotificacion extends StatefulWidget {
  final Notificacion notificacion;
  const LecturaNotificacion({Key? key, required this.notificacion})
      : super(key: key);

  @override
  State<LecturaNotificacion> createState() => _LecturaNotificacionState();
}

class _LecturaNotificacionState extends State<LecturaNotificacion> {
  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Container(
                      margin: const EdgeInsets.all(80),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Text(
                        "${widget.notificacion.asunto}",
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        weekdayToString(
                                widget.notificacion.fechaEnvio?.weekday) +
                            " " +
                            widget.notificacion.fechaEnvio?.day.toString() +
                            " " +
                            monthToString(
                                widget.notificacion.fechaEnvio?.month),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "${widget.notificacion.descripcion}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    )),
                  ],
                ))));
  }
}
