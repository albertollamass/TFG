import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/view/crear.dart';

import '../model/socio.dart';
import 'admin_crear_usuario.dart';
import 'datos_personales.dart';

class AdminUsuarios extends StatefulWidget {
  const AdminUsuarios({super.key});

  @override
  State<AdminUsuarios> createState() => _AdminUsuariosState();
}

class _AdminUsuariosState extends State<AdminUsuarios> {
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "${socio.nombre} ${socio.apellidos}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            child: const SizedBox(
              width: 40,
              child: Icon(Icons.edit),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DatosPersonales(
                          socio: socio,
                          esSolicitud: false,
                        )),
              );
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 20,
              child: Icon(Icons.delete),
            ),
            onTap: () {
              AlertDialog alert = AlertDialog(
                title: const Text("Eliminar socio"),
                content: const Text(
                    "¿Estás seguro de que quieres eliminar a este socio?"),
                actions: [
                  TextButton(
                    child: const Text(
                      "Eliminar socio",
                      style: TextStyle(color: Color(0xffD01E1E)),
                    ),
                    onPressed: () {
                      final docSocio = FirebaseFirestore.instance
                          .collection('socios')
                          .doc('${socio.email}');
                      docSocio.delete();
                      Navigator.pop(context);
                      const snackBar = SnackBar(
                        content: Text('Usuario eliminado correctamente'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                  TextButton(
                    child: const Text("Cancelar"),
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
      );
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
        body: StreamBuilder<List<Socio>>(
          stream: leerSocios(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final socios = snapshot.data!;
              List<String> emails = [];
              for (int i = 0; i < socios.length; i++) {
                emails.add(socios[i].email.toString());
              }
              var cron = Cron();

              cron.schedule(Schedule.parse('0 0 1 * *'), () {
                addOperacion(-20, emails);
                enviarNotificacion("Pago mensualidad", "Recordatorio de que se debe pagar la mensualidad del mes de $monthToString(${DateTime.now().month}", emails);
              });
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
            } else {
              print(snapshot.toString());
              return Text("error");
            }
          },
        ));
  }
}
