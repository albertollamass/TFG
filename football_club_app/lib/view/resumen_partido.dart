import 'package:flutter/material.dart';
import 'package:football_club_app/view/resumen.dart';

class ResumenPartido extends StatefulWidget {
  final DateTime fecha;
  const ResumenPartido({Key? key, required this.fecha}) : super(key: key);
  @override
  State<ResumenPartido> createState() => _ResumenPartidoState();
}

class _ResumenPartidoState extends State<ResumenPartido> {
  Map<String, List<String>> equipos = {
    "negro": ["Antonio", "Joaquin", "M.Pardo", "Sergio", "Francis", "Victor"],
    "blanco": [
      "Rafa",
      "Jose",
      "Juanjo",
      "Nene",
      "Sam",
      "Joseles",
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> equiposW = [];
    equiposW.add(const Text(
      "EQUIPOS",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ));
    equiposW.add(
      const SizedBox(
        height: 20,
      ),
    );
    for (int i = 0; i < equipos.length; i++) {
      equiposW.add(Text(
        equipos.keys.elementAt(i).toString().toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));   
      equiposW.add(
          const SizedBox(height: 5,),
        );   
      for (int j = 0; j < equipos.values.elementAt(i).length; j++) {
        equiposW.add(Row(children: [
          i == 0 ? const Icon(Icons.circle, color: Colors.black,): const Icon(Icons.circle, color: Colors.white,),
          const SizedBox(width: 5,),
          Text(equipos.values.elementAt(i).elementAt(j).toString(),
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),),          
        ]));
        equiposW.add(
          const SizedBox(height: 5,),
        );
      }
      equiposW.add(
          const SizedBox(height: 10,),
        );
      
    }
    return ListView(padding: const EdgeInsets.all(20), children: [
      Column(
        children: [
          Container(
            width: 380,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE2DEE6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: const Text(
              "DETALLES DEL PARTIDO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  const Text("FECHA",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff8F8F8F))),
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
                        weekdayToString(widget.fecha.weekday) +
                            " " +
                            widget.fecha.day.toString() +
                            " " +
                            monthToString(widget.fecha.month),
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        )),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("HORA COMIENZO",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff8F8F8F))),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    const Icon(Icons.alarm, color: Color(0xff3A3970)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("${widget.fecha.hour}:00",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: equiposW,
              )),
        ],
      ),
    ]);
  }
}
