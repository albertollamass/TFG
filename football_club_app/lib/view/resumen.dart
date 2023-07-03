import 'package:flutter/material.dart';
import 'package:football_club_app/model/estadisticas.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';
import 'package:football_club_app/view/info_partido.dart';
import '../controller/controlador.dart';

class Resumen extends StatefulWidget {
  const Resumen({super.key});

  @override
  State<Resumen> createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  @override
  Widget build(BuildContext context) {
    //Tabla clasificacion
    List<Widget> buildClasificacion(List<Estadisticas> jugadores) {
      List<Widget> mywidgets = [];
      jugadores.sort((a, b) {
        int cmp = b.puntos.compareTo(a.puntos);
        if (cmp != 0) return cmp;
        return b.goles.compareTo(a.goles);
      });

      mywidgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          width: 35,
          child: Text(
            "Pos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          width: 70,
          child: Text(
            "Jugador",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: const Text(
            "PJ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: const Text(
            "PG",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: const Text(
            "PP",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: const Text(
            "PE",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          width: 30,
          alignment: Alignment.center,
          child: const Text(
            "Pts",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ]));
      mywidgets.add(const Divider(
        thickness: 2,
      ));

      for (int x = 0; x < jugadores.length; x++) {
        mywidgets.add(FutureBuilder<Socio?>(
          future: leerSocio(jugadores[x].email.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stats = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    child: Text(
                      (x + 1).toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      stats.alias != ""
                          ? stats.alias.toString()
                          : (stats.nombre.toString()),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      jugadores[x].partidosJugados.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      jugadores[x].partidosGanados.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      jugadores[x].partidosPerdidos.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      jugadores[x].partidosPerdidos.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      jugadores[x].puntos.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
        mywidgets.add(const Divider());
      }
      return mywidgets;
    }

    //---------------------------------------------------------------------
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        //ULTIMO PARTIDO
        StreamBuilder<List<Partido>>(
          stream: leerUltimoPartido(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final partidos = snapshot.data!;
              List<Widget> partidosW = [];
              int i = partidos.length-1;
                partidosW.add(InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InfoPartido(
                                partido: partidos[i],
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 380,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xffC1C2C6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: Text(
                          weekdayToString(partidos[i].fechaPartido.weekday) +
                              " " +
                              partidos[i].fechaPartido.day.toString() +
                              " " +
                              monthToString(partidos[i].fechaPartido.month),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(40, 10, 7, 10),
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 2, color: Colors.white))),
                              Text(
                                partidos[i].golesNegro.toString(),
                                style: const TextStyle(fontSize: 35),
                              ),
                              const Text(" - ", style: TextStyle(fontSize: 35)),
                              Text(partidos[i].golesBlanco.toString(),
                                  style: const TextStyle(fontSize: 35)),
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(7, 10, 40, 10),
                                  padding: const EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 1, color: Colors.black))),
                            ]),
                      ),
                    ],
                  ),
                ));
              
              return Column(
                children: partidosW,
              );
            } else {
              return const Text("no data");
            }
          },
        ),

        const SizedBox(
          height: 40,
        ),

        //CLASIFICACION
        Container(
          width: 380,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffC1C2C6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: const Text(
            "CLASIFICACION",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            width: 380,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE0DEE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: StreamBuilder<List<Estadisticas>>(
              stream: leerClasificacion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final socios = snapshot.data!;
                  return Column(
                    children: buildClasificacion(socios),
                  );
                } else {
                  return Text("error");
                }
              },
            ))
      ],
    );
  }
}
