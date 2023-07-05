// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';
import 'package:football_club_app/view/info_partido.dart';

class EditarEquipos extends StatefulWidget {
  Partido partido;
  List<Equipo> equipos;
  List<TextEditingController> equipoJugador = [];
  int k = -1;
  EditarEquipos({
    Key? key,
    required this.partido,
    required this.equipos,
  }) : super(key: key);
  @override
  _EditarEquipos createState() => _EditarEquipos();
}

class _EditarEquipos extends State<EditarEquipos> {
  final ButtonStyle styleInic = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: const Color(0xff3C3577),
      padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0));
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 243, 242, 248);
    List<Widget> buildTeams() {
      List<Widget> res = [];

      for (int i = 0; i < widget.equipos.length; i++) {
        res.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.equipos[i].color.toUpperCase(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ));
        res.add(const Divider(
          thickness: 1,
        ));
        res.add(const SizedBox(
          height: 10,
        ));

        for (int j = 0; j < widget.equipos[i].jugadores.length; j++) {
          res.add(FutureBuilder<Socio?>(
            future: leerSocio(widget.equipos[i].jugadores[j].toLowerCase()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final socio = snapshot.data!;
                widget.equipoJugador
                    .add(TextEditingController(text: widget.equipos[i].color));
                widget.k++;
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        socio.alias != ""
                            ? socio.alias.toString()
                            : ("${socio.nombre} ${socio.apellidos}"),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: TextFormField(
                        controller: widget.equipoJugador[widget.k],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 8,
                      child: InkWell(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: const Text("Eliminar jugador"),
                            content:
                                const Text("¿Quieres eliminar a este jugador?"),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Eliminar",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async {
                                  //print(widget.partido.fechaPartido);
                                  //DateTime fecha = DateTime.fromMillisecondsSinceEpoch(widget.partido.fechaPartido);
                                  print(
                                      "${widget.equipos[i].color}_${widget.partido.fechaPartido}");
                                  final docEquipo = FirebaseFirestore.instance
                                      .collection('equipos')
                                      .doc(
                                          "${widget.equipos[i].color}_${widget.partido.fechaPartido}");
                                  DocumentSnapshot doc = await docEquipo.get();
                                  List jugadores = doc['jugadores'];
                                  if (jugadores.contains(
                                      widget.equipos[i].jugadores[j])) {
                                    docEquipo.update({
                                      'jugadores': FieldValue.arrayRemove(
                                          [widget.equipos[i].jugadores[j]])
                                    }).whenComplete(() => print("done"));
                                  }

                                  Navigator.pop(context);
                                  Navigator.pop(context);
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
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ],
                );
              } else {
                return const Text("nainn");
              }
            },
          ));
          res.add(const SizedBox(
            height: 20,
          ));
        }
      }

      res.add(ElevatedButton(
        onPressed: () async {
          try {
            final docEquipoBlanco = FirebaseFirestore.instance
                .collection('equipos')
                .doc("blanco_${widget.partido.fechaPartido}");
            DocumentSnapshot doc = await docEquipoBlanco.get();
            List jugadores = doc['jugadores'];

            final docEquipoNegro = FirebaseFirestore.instance
                .collection('equipos')
                .doc("negro_${widget.partido.fechaPartido}");
            DocumentSnapshot doc2 = await docEquipoNegro.get();
            List jugadores2 = doc2['jugadores'];

            widget.k = -1;
            print("holu");
            for (int i = 0; i < widget.equipos.length; i++) {
              for (int j = 0; j < widget.equipos[i].jugadores.length; j++) {
                widget.k++;
                //print(widget.equipos[i].jugadores[j]);
                //print(widget.equipoJugador[widget.k].text.trim());
                if (!jugadores.contains(widget.equipos[i].jugadores[j]) &&
                    "blanco" == widget.equipoJugador[widget.k].text.trim()) {
                  docEquipoBlanco.update({
                    'jugadores':
                        FieldValue.arrayUnion([widget.equipos[i].jugadores[j]])
                  }).whenComplete(() => print("doneUnion"));

                  docEquipoNegro.update({
                    'jugadores':
                        FieldValue.arrayRemove([widget.equipos[i].jugadores[j]])
                  }).whenComplete(() => print("doneR"));
                } else if (!jugadores2
                        .contains(widget.equipos[i].jugadores[j]) &&
                    "negro" == widget.equipoJugador[widget.k].text.trim()) {
                  docEquipoBlanco.update({
                    'jugadores':
                        FieldValue.arrayRemove([widget.equipos[i].jugadores[j]])
                  }).whenComplete(() => print("doneUnion"));

                  docEquipoNegro.update({
                    'jugadores':
                        FieldValue.arrayUnion([widget.equipos[i].jugadores[j]])
                  }).whenComplete(() => print("doneR"));
                }
              }
            }
          } on FirebaseException catch (e) {
            print(e.message);
          }
          Navigator.pop(context);
        },
        style: styleInic,
        child: const Center(child: Text("Guardar cambios")),
      ));
      return res;
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            "EDITAR EQUIPOS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          color: backgroundColor,
          child: ListView(
            children: buildTeams(),
          ),
        ));
  }
}
