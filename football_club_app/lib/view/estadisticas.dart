import 'package:flutter/material.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/estadisticas.dart';
import 'package:football_club_app/model/socio.dart';

class EstadisticasW extends StatefulWidget {
  const EstadisticasW({super.key});

  @override
  State<EstadisticasW> createState() => _EstadisticasWState();
}

class _EstadisticasWState extends State<EstadisticasW> {

  @override
  Widget build(BuildContext context) {
    //Ordenamos jugadores con sus goles de mayor a menor

    List<Widget> buildPichichi(List<Estadisticas> clasificacion) {
      List<Widget> mywidgets = [];
      clasificacion.sort((a, b) => b.goles.compareTo(a.goles));
      mywidgets
          .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const SizedBox(
          width: 30,
          child: Text(
            "Pos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          width: 70,
          child: Text(
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
      for (int x = 0; x < clasificacion.length; x++) {
        mywidgets.add(
          FutureBuilder<Socio?>(
            future: leerSocio(clasificacion[x].email),
            builder: (context, snapshot) {              
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 30,
                      child: Text(
                        (x + 1).toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                       user.alias != ""
                          ? user.alias.toString()
                          : (user.nombre.toString()),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].goles.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }else {
                return Text("no data");
              }
            }));
        mywidgets.add(const Divider());
      }
      return mywidgets;
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
            child: StreamBuilder<List<Estadisticas>>(
              stream: leerClasificacion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final clasificacion = snapshot.data!;
                  return Column(
                    children: buildPichichi(clasificacion),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ))
      ],
    );
  }
}
