import 'package:flutter/material.dart';
import 'package:football_club_app/view/resumen.dart';

class Partidos extends StatefulWidget {
  const Partidos({super.key});

  @override
  State<Partidos> createState() => _PartidosState();
}

class _PartidosState extends State<Partidos> {
  final hoy = DateTime.now();
  var resultado = {"negro": 1, "blanco": 0};
  int numpartidos = 8;
  @override
  Widget build(BuildContext context) {
    List<Widget> partidos = [];
  for (int i = 0; i < numpartidos; i++){
    partidos.add(Container(
          width: 380,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color(0xffC1C2C6),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Text(
            weekdayToString(hoy.weekday) +
                " " +
                hoy.day.toString() +
                " " +
                monthToString(hoy.month),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ));
        partidos.add(Container(
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
              resultado["negro"].toString(),
              style: const TextStyle(fontSize: 35),
            ),
            const Text(" - ", style: TextStyle(fontSize: 35)),
            Text(resultado["blanco"].toString(),
                style: const TextStyle(fontSize: 35)),
            Container(
                margin: const EdgeInsets.fromLTRB(7, 10, 40, 10),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1, color: Colors.black))),
          ]),
        ),);
        partidos.add(const SizedBox(height: 40,));
  }
    return ListView(
      padding: const EdgeInsets.all(20),
      children: partidos,
    );
  }
}