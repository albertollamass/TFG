import 'package:flutter/material.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/view/info_partido.dart';
import '../controller/controlador.dart';

class Partidos extends StatefulWidget {
  const Partidos({super.key});

  @override
  State<Partidos> createState() => _PartidosState();
}

class _PartidosState extends State<Partidos> {
  
  @override
  Widget build(BuildContext context) {
    Widget buildPartido(Partido partido) {
      return InkWell(
        child: Column(children: [
          Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffC1C2C6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Text(
              weekdayToString(partido.fechaPartido.weekday) +
                  " " +
                  partido.fechaPartido.day.toString() +
                  " " +
                  monthToString(partido.fechaPartido.month),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE0DEE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(40, 10, 7, 10),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.white))),
              Text(
                partido.golesNegro.toString(),
                style: const TextStyle(fontSize: 35),
              ),
              const Text(" - ", style: TextStyle(fontSize: 35)),
              Text(partido.golesBlanco.toString(),
                  style: const TextStyle(fontSize: 35)),
              Container(
                  margin: const EdgeInsets.fromLTRB(7, 10, 40, 10),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.black))),
            ]),
          ),
          const SizedBox(
            height: 40,
          )
        ]),
        onTap: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InfoPartido(
                          partido: partido,
                          esAdmin: false,
                        )),
              );
        },
      );
    }

    return StreamBuilder<List<Partido>>(
      stream: leerPartidos(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final partidos = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: partidos!.map(buildPartido).toList(),
          );
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}
