// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';
import 'package:football_club_app/view/info_partido.dart';

class AdminPartidos extends StatefulWidget {
  List<String> emails;
  AdminPartidos({
    Key? key,
    required this.emails,
  }) : super(key: key);

  @override
  State<AdminPartidos> createState() => _AdminPartidosState();
}

class _AdminPartidosState extends State<AdminPartidos> {
  DateTime fechaNuevoPartido = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "PARTIDOS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color(0xff2B4EA1),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            heroTag: "btnAdd",
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              AlertDialog alert = AlertDialog(
                title: const Text("Nuevo Partido"),
                content: Container(
                  height: 50,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? pickedDate = (await showDatePicker(
                                context: context,
                                initialDate: fechaNuevoPartido,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101)))!;

                            if (pickedDate != null) {
                              setState(() {
                                fechaNuevoPartido = pickedDate;
                                print(pickedDate);
                              });
                            }
                          },
                          child: const Text("Elige fecha partido")),
                      const Divider(),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Crear Partido",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      try {
                        crearPartido(fechaNuevoPartido);
                        enviarNotificacion("Nuevo partido", "Programado nuevo partido para el día ${fechaNuevoPartido.day} - ${fechaNuevoPartido.month}", widget.emails);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminPartidos(
                                    emails: widget.emails,
                                  )),
                        );
                        const snackBar = SnackBar(
                          content: Text('Partido creado correctamente'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } on FirebaseException catch (e) {
                        const snackBar = SnackBar(
                          content: Text('Error creando partido'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  TextButton(
                    child: const Text("Cancelar"),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                  )
                ],
              );
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  });
            },
            child: const Icon(
              Icons.add,
              size: 35,
            )),
        body: Center(
            child: Container(
          height: 780,
          width: 370,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffffffff),
          ),
          child: StreamBuilder<List<Partido>>(
            stream: leerPartidos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final partidos = snapshot.data;
                List<bool> yaPuesto = [
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false
                ];
                List<Widget> partidosW = [];

                for (int i = 0; i < partidos!.length; i++) {
                  for (int j = 0; j <= 11; j++) {
                    if (partidos[i].fechaPartido.month == (j + 1) &&
                        !yaPuesto[j]) {
                      yaPuesto[j] = true;
                      partidosW.add(Text(
                        monthToString(j + 1) +
                            " ${partidos[i].fechaPartido.year}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ));
                    }
                    if (partidos[i].fechaPartido.month == (j + 1)) {
                      partidosW.add(Row(
                        children: [
                          const SizedBox(
                            height: 40,
                            width: 50,
                            child: Icon(
                              Icons.sports_soccer,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              weekdayToString(
                                      partidos[i].fechaPartido.weekday) +
                                  " " +
                                  partidos[i].fechaPartido.day.toString() +
                                  " " +
                                  monthToString(partidos[i].fechaPartido.month),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ),
                          if (partidos[i]
                                  .fechaPartido
                                  .compareTo(DateTime.now()) <
                              0)
                            SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${partidos[i].golesNegro}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const Text(" - ",
                                        style: TextStyle(fontSize: 20)),
                                    Text("${partidos[i].golesBlanco}",
                                        style: const TextStyle(fontSize: 20)),
                                  ],
                                ))
                        ],
                      ));

                      partidosW.add(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (() async => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoPartido(
                                              partido: partidos[i],
                                              esAdmin: true,
                                            )),
                                  )
                                }),
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                                backgroundColor: const Color(0xff8F71E6),
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 16.0, 10.0, 16.0)),
                            child:
                                const Center(child: Text("Editar resultado")),
                          ),
                          if (partidos[i]
                                  .fechaPartido
                                  .compareTo(DateTime.now()) >=
                              0)
                            ElevatedButton(
                              onPressed: () {
                                AlertDialog alert = AlertDialog(
                                  title: const Text("Anular partido"),
                                  content: const Text(
                                      "¿Estás seguro de que anular este partido?"),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        "Anular partido",
                                        style:
                                            TextStyle(color: Color(0xffD01E1E)),
                                      ),
                                      onPressed: () {
                                        try {
                                          final docPartido = FirebaseFirestore
                                              .instance
                                              .collection('partidos')
                                              .doc(partidos[i]
                                                  .fechaPartido
                                                  .millisecondsSinceEpoch
                                                  .toString());
                                          docPartido.delete();

                                          FirebaseFirestore.instance
                                              .collection('equipos')
                                              .doc(
                                                  "negro_${partidos[i].fechaPartido}")
                                              .delete();
                                          FirebaseFirestore.instance
                                              .collection('equipos')
                                              .doc(
                                                  "blanco_${partidos[i].fechaPartido}")
                                              .delete();
                                          enviarNotificacion(
                                              "Cancelado ${partidos[i].fechaPartido.day}-${partidos[i].fechaPartido.month}",
                                              "Se ha cancelado el partido del día ${partidos[i].fechaPartido}",
                                              widget.emails);

                                          Navigator.pop(context);
                                          const snackBar = SnackBar(
                                            content: Text('Partido anulado'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } on FirebaseException catch (e) {
                                          const snackBar = SnackBar(
                                            content:
                                                Text('Error anulando partido'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const AdminPartidos()),
                                        // );
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
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  backgroundColor: const Color(0xffED655F),
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 16.0, 10.0, 16.0)),
                              child:
                                  const Center(child: Text("Anular partido")),
                            ),
                          if (partidos[i]
                                  .fechaPartido
                                  .compareTo(DateTime.now()) >=
                              0)
                            ElevatedButton(
                              onPressed: () {
                                //crearEstadisticasAleatorias(widget.emails);
                                try {
                                  generarEquiposAleatorios(
                                      widget.emails, partidos[i].fechaPartido);
                                } on FirebaseException catch (e) {
                                  print(e.message);
                                }
                                const snackBar = SnackBar(
                                  content:
                                      Text('Equipos generados correctamente'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  backgroundColor: const Color(0xff68CBD9),
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 16.0, 10.0, 16.0)),
                              child:
                                  const Center(child: Text("Generar equipos")),
                            ),
                        ],
                      ));
                      partidosW.add(const SizedBox(
                        height: 10,
                      ));
                    }
                  }
                  // partidosW.add(Text("${partidos[i].fechaPartido}"));
                }
                return ListView(
                  children: partidosW,
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text("error hay partidos" + snapshot.error.toString());
              } else {
                return const Text("no hay partidos");
              }
            },
          ),
        )));
  }
}
