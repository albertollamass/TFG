import 'package:flutter/material.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/view/resumen.dart';

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

    Map<String, int> resultado = {"negro":1,"blanco":0};
    Partido partido1 = Partido(equipos: equipos, fechaPartido: DateTime(2023, 3, 13), resultado: resultado);
    Partido partido2 = Partido(equipos: equipos, fechaPartido: DateTime(2023, 4, 20), resultado: resultado);

    List<Partido> partidos = [];
    partidos.add(partido1); partidos.add(partido2); partidos.add(partido1);

    bool yaPuesto = false;
    List<Widget> partidosW = [];

    for (int i = 0; i < partidos.length; i++) {
      for (int j = 1; j <= 12 && !yaPuesto; j++) {
        if (partidos[i].fechaPartido.month == j){
          yaPuesto = true;
          partidosW.add(
            Text(
                monthToString(j) + " ${partidos[i].fechaPartido.year}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
          );
        } else if (yaPuesto){
          partidosW.add(Text("${partidos[i].fechaPartido.toString()}"));
        }
      }
      yaPuesto = false;      
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
