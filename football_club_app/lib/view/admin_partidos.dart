import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/view/info_partido.dart';
import 'package:football_club_app/controller/controlador.dart';

class AdminPartidos extends StatefulWidget {
  const AdminPartidos({super.key});

  @override
  State<AdminPartidos> createState() => _AdminPartidosState();
}

class _AdminPartidosState extends State<AdminPartidos> {
  //Hacer fetch partidos

  @override
  Widget build(BuildContext context) {
    Equipo equipo1 = Equipo(
        color: "negro",
        fechaEquipo: DateTime(2023, 3, 13),
        jugadores: [
          "Antonio",
          "Joaquin",
          "M.Pardo",
          "Sergio",
          "Francis",
          "Victor"
        ]);
    Equipo equipo2 =
        Equipo(color: "blanco", fechaEquipo: DateTime(2023, 3, 13), jugadores: [
      "Rafa",
      "Jose",
      "Juanjo",
      "Nene",
      "Sam",
      "Joseles",
    ]);

    List<Equipo> equipos = [];
    equipos.add(equipo1);
    equipos.add(equipo2);

    List<Partido> partidos = [];

    partidos.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(a.fechaPartido.toString())
          .compareTo(DateTime.parse(b.fechaPartido.toString()));
    });

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
                                  .compareTo(DateTime.now()) >
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
                                        final docPartido = FirebaseFirestore.instance.collection('partidos').doc(partidos[i].fechaPartido.millisecondsSinceEpoch.toString());
                                        docPartido.delete();
                                        Navigator.pop(context);
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const AdminPartidos()),
                                        // );
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Cancel"),
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
                                  .compareTo(DateTime.now()) >
                              0)
                            ElevatedButton(
                              onPressed: (() async => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminPartidos()),
                                    )
                                  }),
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
