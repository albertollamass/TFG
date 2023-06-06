import 'package:flutter/material.dart';
import 'package:football_club_app/view/info_partido.dart';

class Resumen extends StatefulWidget {
  const Resumen({super.key});

  @override
  State<Resumen> createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  final hoy = DateTime.now();
  var resultado = {"negro": 1, "blanco": 0};
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
    //Tabla clasificacion
    List<Widget> mywidgets = [];
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
      mywidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              (x + 1).toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 70,
            child: Text(
              jugadores[x],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              4.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              4.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              4.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              4.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            width: 30,
            alignment: Alignment.center,
            child: const Text(
              "100",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ));
      mywidgets.add(const Divider());
    }

    //---------------------------------------------------------------------
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        //ULTIMO PARTIDO
        InkWell(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPartido(fecha: hoy, resultado: resultado,)),
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
                  weekdayToString(hoy.weekday) +
                      " " +
                      hoy.day.toString() +
                      " " +
                      monthToString(hoy.month),
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
                          margin: const EdgeInsets.fromLTRB(40, 10, 7, 10),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(width: 2, color: Colors.white))),
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
                              border:
                                  Border.all(width: 1, color: Colors.black))),
                    ]),
              ),
            ],
          ),
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
            child: Column(children: mywidgets,))
      ],
    );
  }
}

weekdayToString(int? weekday) {
  if (weekday == 1) {
    return "Lunes";
  } else if (weekday == 2) {
    return "Martes";
  } else if (weekday == 3) {
    return "Miércoles";
  } else if (weekday == 4) {
    return "Jueves";
  } else if (weekday == 5) {
    return "Viernes";
  } else if (weekday == 6) {
    return "Sábado";
  } else {
    return "Domingo";
  }
}


monthToString(int? month) {
  if (month == 1) {
    return "Enero";
  } else if (month == 2) {
    return "Febrero";
  } else if (month == 3) {
    return "Marzo";
  } else if (month == 4) {
    return "Abril";
  } else if (month == 5) {
    return "Mayo";
  } else if (month == 6) {
    return "Junio";
  } else if (month == 7) {
    return "Julio";
  } else if (month == 8) {
    return "Agosto";
  } else if (month == 9) {
    return "Septiembre";
  } else if (month == 10) {
    return "Octubre";
  } else if (month == 11) {
    return "Noviembre";
  } else {
    return "Diciembre";
  }
}
