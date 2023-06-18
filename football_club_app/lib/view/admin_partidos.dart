import 'package:flutter/material.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/view/info_partido.dart';
import 'package:football_club_app/view/resumen.dart';
import 'package:football_club_app/view/resumen_partido.dart';

import '../model/socio.dart';

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

    Map<String, int> resultado = {"negro": 1, "blanco": 0};
    Map<String, int> resultadoNull = {"negro": -1, "blanco": -1};
    Partido partido1 = Partido(
        equipos: equipos,
        fechaPartido: DateTime(2023, 3, 13),
        resultado: resultado);
    Partido partido2 = Partido(
        equipos: equipos,
        fechaPartido: DateTime(2023, 6, 20),
        resultado: resultadoNull);
    Partido partido3 = Partido(
        equipos: equipos,
        fechaPartido: DateTime(2023, 1, 24),
        resultado: resultado);

    List<Partido> partidos = [];
    partidos.add(partido1);
    partidos.add(partido2);
    partidos.add(partido3);

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

    partidos.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(a.fechaPartido.toString())
          .compareTo(DateTime.parse(b.fechaPartido.toString()));
    });

    List<Widget> partidosW = [];

    for (int i = 0; i < partidos.length; i++) {
      for (int j = 0; j <= 11; j++) {
        if (partidos[i].fechaPartido.month == (j + 1) && !yaPuesto[j]) {
          yaPuesto[j] = true;
          partidosW.add(Text(
            monthToString(j + 1) + " ${partidos[i].fechaPartido.year}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  weekdayToString(partidos[i].fechaPartido.weekday) +
                      " " +
                      partidos[i].fechaPartido.day.toString() +
                      " " +
                      monthToString(partidos[i].fechaPartido.month),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              if (partidos[i].fechaPartido.compareTo(DateTime.now()) < 0)
                SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          partidos[i].resultado["negro"].toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text(" - ", style: TextStyle(fontSize: 20)),
                        Text(partidos[i].resultado["blanco"].toString(),
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
                                  fecha: partidos[i].fechaPartido,
                                  resultado: partidos[i].resultado,
                                  esAdmin: true,
                                )),
                      )
                    }),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                    backgroundColor: const Color(0xff8F71E6),
                    padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0)),
                child: const Center(child: Text("Editar resultado")),
              ),
              if (partidos[i].fechaPartido.compareTo(DateTime.now()) > 0)
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
                            style: TextStyle(color: Color(0xffD01E1E)),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminPartidos()),
                            )
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
                          fontSize: 10, fontWeight: FontWeight.bold),
                      backgroundColor: const Color(0xffED655F),
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0)),
                  child: const Center(child: Text("Anular partido")),
                ),
              if (partidos[i].fechaPartido.compareTo(DateTime.now()) > 0)
              ElevatedButton(
                onPressed: (() async => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPartidos()),
                      )
                    }),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                    backgroundColor: const Color(0xff68CBD9),
                    padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0)),
                child: const Center(child: Text("Generar equipos")),
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
          child: ListView(
            children: partidosW,
          ),
        )));
  }
}
