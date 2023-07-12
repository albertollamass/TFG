// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';

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
  List<String> items = ["blanco", "negro"];
  List<String> equipoJugador2 = ["blanco", "blanco", "blanco", "blanco", "blanco", "blanco", "negro", "negro", "negro", "negro", "negro", "negro", ];
  @override
  Widget build(BuildContext context) {
    
    const backgroundColor = Color.fromARGB(255, 243, 242, 248);
    List<Widget> buildTeams() {
      widget.k = -1;
      List<Widget> res = [];
      int v = 0;
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
                //equipoJugador2.add(widget.equipos[i].color);
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
                      child: DropdownButton<String>(
                        value: i == 0 ? equipoJugador2[(j+1) - 1]
                          : equipoJugador2[6+((j+1) - 1)],
                        items: items
                                .map((item) => DropdownMenuItem<String>(value: item,child: Text(item),)).toList(),
                        onChanged: ((value) => setState(() {
                          i == 0 ? equipoJugador2[(j+1) - 1] = value.toString()
                          : equipoJugador2[6+((j+1) - 1)] = value.toString();                          
                        })),
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
                                  final docEquipo = FirebaseFirestore.instance
                                      .collection('equipos')
                                      .doc(
                                          "${widget.equipos[i].color}_${widget.partido.fechaPartido}");
                                  DocumentSnapshot doc = await docEquipo.get();
                                  List jugadores = doc['jugadores'];
                                  if (jugadores.contains(
                                      widget.equipos[i].jugadores[j])) {                                    

                                    equipoJugador2.removeAt(i == 0 ? (j+1) - 1 : 6+((j+1) - 1));
                                    docEquipo.update({
                                      'jugadores': FieldValue.arrayRemove(
                                          [widget.equipos[i].jugadores[j]])
                                    });
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
                        child: const Icon(Icons.delete),
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
          v++;
        }
      }
      
      v= 0;
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
            for (int i = 0; i < widget.equipos.length; i++) {
              for (int j = 0; j < widget.equipos[i].jugadores.length; j++) {
                widget.k++;
                if ("blanco" == equipoJugador2[widget.k]) {
                  docEquipoBlanco.update({
                    'jugadores':
                        FieldValue.arrayUnion([widget.equipos[i].jugadores[j]])
                  });
                  docEquipoNegro.update({
                    'jugadores':
                        FieldValue.arrayRemove([widget.equipos[i].jugadores[j]])
                  });
                } else if ("negro" ==
                    equipoJugador2[widget.k]) {
                  docEquipoBlanco.update({
                    'jugadores':
                        FieldValue.arrayRemove([widget.equipos[i].jugadores[j]])
                  });

                  docEquipoNegro.update({
                    'jugadores':
                        FieldValue.arrayUnion([widget.equipos[i].jugadores[j]])
                  });
                }
              }
            }
            const snackBar = SnackBar(
              content: Text('Equipos cambiados correctamente'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } on FirebaseException catch (e) {
            const snackBar = SnackBar(
              content: Text('Error cambiando equipos'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          Navigator.pop(context);
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
