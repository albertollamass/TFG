// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';
import 'package:football_club_app/view/editar_equipos.dart';
import '../controller/controlador.dart';

class ResumenPartido extends StatefulWidget {
  Partido partido;
  final bool esAdmin;

  TimeOfDay horaPartido = const TimeOfDay(hour: 20, minute: 00);

  ResumenPartido({
    Key? key,
    required this.partido,
    required this.esAdmin,
  }) : super(key: key);

  @override
  State<ResumenPartido> createState() => _ResumenPartidoState();
}

class _ResumenPartidoState extends State<ResumenPartido> {
  List<String> cambioEnGoles = [];
  List<TextEditingController> golesJugadores = [];
  @override
  Widget build(BuildContext context) {
    //crearResultado(equipos, goles);
    List<Widget> buildEquipos(List<Equipo> equipos) {
      for (int x = 0; x < widget.partido.goles.length; x++) {}

      List<Widget> equiposW = [];
      final ButtonStyle styleInic = ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xff3C3577),
          padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0));

      equiposW.add(Row(
        children: [
          const Text(
            "EQUIPOS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          ),
          widget.esAdmin
              ? InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarEquipos(
                              partido: widget.partido, equipos: equipos)),
                    );
                  })
              : const Text(""),
        ],
      ));
      equiposW.add(
        const SizedBox(
          height: 20,
        ),
      );
      int k = 0;
      for (int i = 0; i < equipos.length; i++) {
        equiposW.add(Text(
          equipos[i].color.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
        equiposW.add(
          const SizedBox(
            height: 10,
          ),
        );
        for (int j = 0; j < equipos[i].jugadores.length; j++) {
          golesJugadores.add(TextEditingController(
              text: widget.partido
                          .goles[equipos[i].jugadores[j].toLowerCase()] !=
                      null
                  ? widget.partido.goles[equipos[i].jugadores[j].toLowerCase()]
                      .toString()
                  : "0"));
          equiposW.add(Row(children: [
            i == 1
                ? const Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 40,
                  )
                : const Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 40,
                  ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 170,

              child: FutureBuilder<Socio?>(
                future: leerSocio(equipos[i].jugadores[j].toLowerCase()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Text(
                      user.alias != ""
                          ? user.alias.toString()
                          : ("${user.nombre} ${user.apellidos}"),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),

              // child: Text(
              //   equipos[i].jugadores[j],
              //   style:
              //       const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              // ),
            ),
            widget.esAdmin
                ? SizedBox(
                    width: 23,
                    child: TextFormField(
                      controller: golesJugadores[k],
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2)
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  )
                : widget.partido.goles.keys.contains(equipos[i].jugadores[j]) &&
                        widget.partido.goles[equipos[i].jugadores[j]]! > 0
                    ? Text(widget.partido.goles[equipos[i].jugadores[j]]
                        .toString())
                    : const Text(""),
            const SizedBox(width: 5),
            widget.esAdmin
                ? const Icon(
                    Icons.sports_soccer,
                    size: 30,
                  )
                // : indexGol != -1
                //     ? const Icon(
                //         Icons.sports_soccer,
                //         size: 30,
                //       )
                : widget.partido.goles.keys.contains(equipos[i].jugadores[j]) &&
                        widget.partido.goles[equipos[i].jugadores[j]]! > 0
                    ? const Icon(
                        Icons.sports_soccer,
                        size: 30,
                      )
                    : const Text(""),
          ]));
          equiposW.add(
            const SizedBox(
              height: 10,
            ),
          );
          k++;
        }
        equiposW.add(
          const SizedBox(
            height: 10,
          ),
        );
      }

      equiposW.add(
        widget.esAdmin
            ? ElevatedButton(
                onPressed: () async {
                  Map<String, int> golesPartido = {};
                  List<String> emails = [];
                  try {
                    widget.partido.golesBlanco = 0;
                    widget.partido.golesNegro = 0;

                    int k = 0;
                    for (int i = 0; i < equipos.length; i++) {
                      for (int j = 0; j < equipos[i].jugadores.length; j++) {
                        emails.add(equipos[i].jugadores[j].toLowerCase());
                        if (!widget.partido.yaEditado) {
                          cambioEnGoles.add(golesJugadores[k].text.trim());
                          actualizarGolesJugador(
                              equipos[i].jugadores[j].toLowerCase(),
                              golesJugadores[k].text.trim());
                        } else {
                          if (widget.partido.goles
                              .containsKey(equipos[i].jugadores[j])) {
                            if (widget.partido.goles[equipos[i].jugadores[j]]! <
                                int.parse(golesJugadores[k].text.trim())) {
                              int dif =
                                  int.parse(golesJugadores[k].text.trim()) -
                                      widget.partido
                                          .goles[equipos[i].jugadores[j]]!;
                              actualizarGolesJugador(
                                  equipos[i].jugadores[j].toLowerCase(),
                                  dif.toString());
                            } else {
                              var dif =
                                  int.parse(golesJugadores[k].text.trim()) -
                                      widget.partido
                                          .goles[equipos[i].jugadores[j]]!;
                              actualizarGolesJugador(
                                  equipos[i].jugadores[j].toLowerCase(),
                                  dif.toString());
                            }
                          }
                        }

                        final gol = <String, int>{
                          equipos[i].jugadores[j].toLowerCase():
                              int.parse(golesJugadores[k].text.trim())
                        };
                        golesPartido.addEntries(gol.entries);
                        if (equipos[i].color == "blanco") {
                          widget.partido.golesBlanco =
                              widget.partido.golesBlanco +
                                  int.parse(golesJugadores[k].text.trim());
                        } else {
                          widget.partido.golesNegro =
                              widget.partido.golesNegro +
                                  int.parse(golesJugadores[k].text.trim());
                        }
                        k++;
                      }
                    }
                    bool blancoGanado = false, negroGanado = false;
                    if (widget.partido.golesBlanco >
                        widget.partido.golesNegro) {
                      blancoGanado = true;
                    } else if (widget.partido.golesBlanco <
                        widget.partido.golesNegro) {
                      negroGanado = true;
                    }

                    final docPartido = FirebaseFirestore.instance
                        .collection('partidos')
                        .doc(widget.partido.fechaPartido.millisecondsSinceEpoch
                            .toString());
                    DocumentSnapshot snapshot = await docPartido.get();

                    if (snapshot.exists) {
                      docPartido.update({
                        'golesBlanco': widget.partido.golesBlanco,
                        'golesNegro': widget.partido.golesNegro,
                        'goles': golesPartido,
                        'yaEditado': true
                      });
                    }
                    if (!snapshot['yaEditado']) {
                      for (int i = 0; i < equipos.length; i++) {
                        for (int j = 0; j < equipos[i].jugadores.length; j++) {
                          if (blancoGanado) {
                            if (equipos[i].color == "blanco") {
                              actualizarPartidosGanador(
                                  equipos[i].jugadores[j].toLowerCase());
                            } else {
                              actualizarPartidosPerdedor(
                                  equipos[i].jugadores[j].toLowerCase());
                            }
                          } else if (negroGanado) {
                            if (equipos[i].color == "negro") {
                              actualizarPartidosGanador(
                                  equipos[i].jugadores[j].toLowerCase());
                            } else {
                              actualizarPartidosPerdedor(
                                  equipos[i].jugadores[j].toLowerCase());
                            }
                          } else {
                            //print(equipos[i].jugadores[j]);
                            actualizarPartidosEmpate(
                                equipos[i].jugadores[j].toLowerCase());
                          }
                        }
                      }
                    }
                    golesJugadores.clear();
                    const snackBar = SnackBar(
                      content: Text('Resultado editado correctamente'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } on FirebaseException catch (e) {
                    const snackBar = SnackBar(
                      content: Text('Error editando resultado'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (!widget.partido.yaEditado) {
                    DateTime sigPartido = widget.partido.fechaPartido
                        .add(const Duration(days: 7));
                    Equipo equipo1 = Equipo(
                        color: "negro",
                        fechaEquipo: sigPartido,
                        jugadores: [
                          "antonio@gmail.com",
                          "joaquin@gmail.com",
                          "m.pardo@gmail.com",
                          "sergio@gmail.com",
                          "francis@gmail.com",
                          "victor@gmail.com"
                        ]);
                    Equipo equipo2 = Equipo(
                        color: "blanco",
                        fechaEquipo: sigPartido,
                        jugadores: [
                          "rafa@gmail.com",
                          "jose@gmail.com",
                          "juanjo@gmail.com",
                          "nene@gmail.com",
                          "sam@gmail.com",
                          "joseles@gmail.com",
                        ]);
                    crearEquipo(equipo1, equipo2);
                    crearPartido(sigPartido);
                    enviarNotificacion(
                        "Partido ${sigPartido.day}-${sigPartido.month}",
                        "Se recuerda que el próximo partido será el ${sigPartido.day}-${sigPartido.month} a las 20:00",
                        emails);
                  }

                  Navigator.pop(context);
                },
                style: styleInic,
                child: const Center(child: Text("Guardar cambios")),
              )
            : const Text(""),
      );

      return equiposW;
    }

    return ListView(padding: const EdgeInsets.all(20), children: [
      Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white))),
            widget.partido.yaEditado
                ? Text(
                    widget.partido.golesNegro.toString(),
                    style: const TextStyle(fontSize: 45),
                  )
                : const Text(""),
            const Text(" - ", style: TextStyle(fontSize: 45)),
            widget.partido.yaEditado
                ? Text(widget.partido.golesBlanco.toString(),
                    style: const TextStyle(fontSize: 45))
                : const Text(""),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.black))),
          ]),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE2DEE6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Row(
              children: const [
                Text(
                  "DETALLES DEL PARTIDO",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
              width: 380,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xffE2DEE6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("FECHA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff8F8F8F))),
                      const SizedBox(
                        width: 30,
                      ),
                      widget.esAdmin
                          ? InkWell(
                              child: const Icon(Icons.edit),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: widget.partido.fechaPartido,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(pickedDate);

                                  setState(() {
                                    widget.partido.fechaPartido = pickedDate;
                                  });
                                } else {}
                              },
                            )
                          : const Text("")
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.date_range,
                      color: Color(0xff3A3970),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                        weekdayToString(widget.partido.fechaPartido.weekday) +
                            " " +
                            widget.partido.fechaPartido.day.toString() +
                            " " +
                            monthToString(widget.partido.fechaPartido.month),
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        )),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text("HORA COMIENZO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff8F8F8F))),
                      const SizedBox(
                        width: 30,
                      ),
                      widget.esAdmin
                          ? InkWell(
                              child: const Icon(Icons.edit),
                              onTap: () async {
                                TimeOfDay initialTime = TimeOfDay(
                                    hour: widget.partido.fechaPartido.hour,
                                    minute: widget.partido.fechaPartido.minute);
                                TimeOfDay? pickedDate = await showTimePicker(
                                  context: context,
                                  initialTime: initialTime,
                                ); //get today's time
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  //You can format date as per your need

                                  setState(() {
                                    widget.horaPartido = pickedDate;
                                    //set foratted date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                                //widget.fecha.hour = horaPartido.hour;
                              },
                            )
                          : const Text("")
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    const Icon(Icons.alarm, color: Color(0xff3A3970)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                        widget.horaPartido.minute < 10
                            ? "${widget.horaPartido.hour}:0${widget.horaPartido.minute}"
                            : "${widget.horaPartido.hour}:${widget.horaPartido.minute}",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        )),
                  ]),
                ],
              )),
        ],
      ),
      const SizedBox(
        height: 40,
      ),
      Column(
        children: [
          Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffE2DEE6),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: StreamBuilder<List<Equipo>>(
              stream: leerEquiposPartido(widget.partido.fechaPartido),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final equipos = snapshot.data!;
                  List<Widget> equiposW = buildEquipos(equipos);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: equiposW,
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Text("error");
                } else {
                  return const Text("data");
                }
              },
            ),
          )
        ],
      ),
    ]);
  }
}
