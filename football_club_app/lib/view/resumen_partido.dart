// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:football_club_app/view/draggable_list.dart';
import '../controller/controlador.dart';

class ResumenPartido extends StatefulWidget {
  DateTime fecha;
  final bool esAdmin;
  final Map<String, int> resultado;

  TimeOfDay horaPartido = TimeOfDay.now();

  ResumenPartido({
    Key? key,
    required this.fecha,
    required this.esAdmin,
    required this.resultado,
  }) : super(key: key);

  @override
  State<ResumenPartido> createState() => _ResumenPartidoState();
}

class _ResumenPartidoState extends State<ResumenPartido> {
  void crearResultado(var equipos, var goles) {
    widget.resultado["negro"] = 0;
    widget.resultado["blanco"] = 0;
    for (int i = 0; i < goles.length; i++) {
      for (int j = 0; j < equipos.length; j++) {

        for (int k = 0; k < equipos.values.elementAt(j).length; k++) {
          //print(goles.keys.elementAt(i) + " " + equipos.values.elementAt(j).elementAt(k));
          //print (equipos.keys.elementAt(j) + " " + widget.resultado[equipos.keys.elementAt(j)].toString());
          if (goles.keys.elementAt(i) == equipos.values.elementAt(j).elementAt(k)) {
            widget.resultado[equipos.keys.elementAt(j)] = (widget.resultado[equipos.keys.elementAt(j)]! + goles.values.elementAt(i)) as int;
            //print(widget.resultado[equipos.keys.elementAt(j)]);
          }
        }
      }
    }
  }

  Map<String, List<String>> equipos = {
    "negro": ["Antonio", "Joaquin", "M.Pardo", "Sergio", "Francis", "Victor"],
    "blanco": ["Rafa", "Jose", "Juanjo", "Nene", "Sam", "Joseles"]
  };

  Map<String, int> goles = {
    "Joaquin": 1,
  };

  bool tieneGol = false;

  @override
  Widget build(BuildContext context) {
    crearResultado(equipos, goles);
    const List<String> list = <String>['0', '1', '2', '3', '4'];
    String dropdownValue = list.first;
    List<Widget> equiposW = [];
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
        equipos.keys.elementAt(i).toString().toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
      equiposW.add(
        const SizedBox(
          height: 10,
        ),
      );
      for (int j = 0; j < equipos.values.elementAt(i).length; j++) {
        int indexGol = -1;
        for (int k = 0; k < goles.length && !tieneGol; k++) {
          //print(goles.values.elementAt(k).toString() +
             // equipos.values.elementAt(i).elementAt(j).toString());
          // print(equipos.values.elementAt(i).elementAt(j).toString());
          if (equipos.values.elementAt(i).elementAt(j).toString() ==
              goles.keys.elementAt(k).toString()) {
            tieneGol = true;
            indexGol = k;
            //print(indexGol);
          }
        }

        equiposW.add(Row(children: [
          i == 0
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
            child: Text(
              equipos.values.elementAt(i).elementAt(j).toString(),
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          widget.esAdmin
              ? DropdownButton<String>(
                  value: indexGol != -1
                      ? goles.values.elementAt(indexGol).toString()
                      : dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              : indexGol != -1 ? Text(goles.values.elementAt(indexGol).toString(), style: const TextStyle(fontSize: 22),) : const Text(""),
          const SizedBox(width: 5),
          widget.esAdmin
              ? const Icon(
                  Icons.sports_soccer,
                  size: 30,
                )
              : indexGol != -1 ? const Icon(
                  Icons.sports_soccer,
                  size: 30,
                ): const Text(""),
        ]));
        equiposW.add(
          const SizedBox(
            height: 10,
          ),
        );
        if (indexGol > 0) {
          indexGol = -1;
        }

        if (tieneGol) {
          tieneGol = false;
        }
      }
      equiposW.add(
        const SizedBox(
          height: 10,
        ),
      );
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
            widget.resultado["negro"]! >= 0
                ? Text(
                    widget.resultado["negro"].toString(),
                    style: const TextStyle(fontSize: 45),
                  )
                : const Text(""),
            const Text(" - ", style: TextStyle(fontSize: 45)),
            widget.resultado["blanco"]! >= 0
                ? Text(widget.resultado["blanco"].toString(),
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
                                    initialDate:
                                        widget.fecha, //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  //You can format date as per your need

                                  setState(() {
                                    widget.fecha =
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
                                    hour: widget.fecha.hour,
                                    minute: widget.fecha.minute);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: equiposW,
              )),
        ],
      ),
    ]);
  }
}
