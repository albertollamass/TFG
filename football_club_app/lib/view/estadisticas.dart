import 'package:flutter/material.dart';

class Estadisticas extends StatefulWidget {
  const Estadisticas({super.key});

  @override
  State<Estadisticas> createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  var goles = {
    "Rafa": 13,
    "Jose": 15,
    "Juanjo": 16,
    "Nene": 2,
    "Sam": 7,
    "Joseles": 9,
    "Antonio": 1,
    "Joaquin": 10,
    "M.Pardo": 3,
    "Sergio": 4,
    "Francis": 6,
    "Victor": 4,
  };

  var jugadores = [
    "Rafa",
    "Jose",
    "Juanjo",
    "Nene",
    "Sam",
    "Joseles",
    "Antonio",
    "Joaquin",
    "M.Pardo",
    "Sergio",
    "Francis",
    "Victor"
  ];

  @override
  Widget build(BuildContext context) {
    //Ordenamos jugadores con sus goles de mayor a menor
    var sortedMap = Map.fromEntries(
        goles.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
    
    List<Widget> mywidgets = [];
    mywidgets
        .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        width: 30,
        child: const Text(
          "Pos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 70,
        child: const Text(
          "Jugador",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        width: 50,
        alignment: Alignment.center,
        child: const Text(
          "Goles",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ]));
    mywidgets.add(const Divider(
      thickness: 2,
    ));
    for (int x = 0; x < sortedMap.length; x++) {
      mywidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 30,
            child: Text(
              (x + 1).toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              sortedMap.keys.elementAt(x),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 50,
            alignment: Alignment.center,
            child: Text(
              sortedMap[sortedMap.keys.elementAt(x)].toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ));
      mywidgets.add(const Divider());
    }
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffC1C2C6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [                
                Text(
                  "MÁXIMOS GOLEADORES",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded)
              ],
            )),
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
            child: Column(children: mywidgets))
      ],
    );
  }
}
