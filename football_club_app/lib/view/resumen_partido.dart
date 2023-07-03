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
  List<TextEditingController> golesJugadores = [];
  @override
  Widget build(BuildContext context) {
    print(widget.partido.fechaPartido.millisecondsSinceEpoch);
    //crearResultado(equipos, goles);
    List<Widget> buildEquipos(List<Equipo> equipos) {
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
                      MaterialPageRoute(builder: (context) => EditarEquipos()),
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
          golesJugadores.add(TextEditingController());
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
                      user.alias != "" ? user.alias.toString() :("${user.nombre} ${user.apellidos}"),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    );
                  } else {
                    return const Text("no existe ese jugador");
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
                      controller: golesJugadores[j],
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                    ),
                  )
                // : indexGol != -1
                //     ? Text(
                //         goles.values.elementAt(indexGol).toString(),
                //         style: const TextStyle(fontSize: 22),
                //       )
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
                : const Text(""),
          ]));
          equiposW.add(
            const SizedBox(
              height: 10,
            ),
          );
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
                  try {
                    for (int i = 0; i < equipos.length; i++) {
                      for (int j = 0; j < equipos[i].jugadores.length; j++) {
                        actualizarGolesJugador(equipos[i].jugadores[j],
                            golesJugadores[j].text.trim());
                      }
                    }
                  } on FirebaseException catch (e) {
                    print(e.message);
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
            widget.partido.golesNegro >= 0
                ? Text(
                    widget.partido.golesNegro.toString(),
                    style: const TextStyle(fontSize: 45),
                  )
                : const Text(""),
            const Text(" - ", style: TextStyle(fontSize: 45)),
            widget.partido.golesBlanco >= 0
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
                                    initialDate: widget.partido
                                        .fechaPartido, //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  //You can format date as per your need

                                  setState(() {
                                    widget.partido.fechaPartido =
                                        pickedDate; //set foratted date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
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
