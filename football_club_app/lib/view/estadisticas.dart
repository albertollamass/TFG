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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 70,
          child: Text(
            "Jugador",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: const Text(
            "Goles",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ]));
      mywidgets.add(const Divider(
        thickness: 2,
      ));
      for (int x = 0; x < clasificacion.length; x++) {
        mywidgets.add(FutureBuilder<Socio?>(
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
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        user.alias != ""
                            ? user.alias.toString()
                            : (user.nombre.toString()),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].goles.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("");
              }
            }));
        mywidgets.add(const Divider());
      }
      return mywidgets;
    }

    List<Widget> buildPuntosPartido(List<Estadisticas> clasificacion) {
      List<Widget> mywidgets = [];
      clasificacion.sort((a, b) =>
          (b.partidosJugados == 0 ? (b.puntos / b.partidosJugados) : b.puntos)
              .compareTo(a.partidosJugados == 0
                  ? (a.puntos / a.partidosJugados)
                  : a.puntos));
      mywidgets
          .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const SizedBox(
          width: 30,
          child: Text(
            "Pos",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 70,
          child: Text(
            "Jugador",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(
            "Puntos",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: const Text(
            "PJ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ]));
      mywidgets.add(const Divider(
        thickness: 2,
      ));
      for (int x = 0; x < clasificacion.length; x++) {
        mywidgets.add(FutureBuilder<Socio?>(
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
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        user.alias != ""
                            ? user.alias.toString()
                            : (user.nombre.toString()),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].puntos.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].partidosJugados.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("");
              }
            }));
        mywidgets.add(const Divider());
      }
      return mywidgets;
    }

    List<Widget> buildGolesPartido(List<Estadisticas> clasificacion) {
      List<Widget> mywidgets = [];
      clasificacion.sort((a, b) =>
          (b.partidosJugados == 0 ? (b.goles / b.partidosJugados) : b.goles)
              .compareTo(a.partidosJugados == 0
                  ? (a.goles / a.partidosJugados)
                  : a.goles));
      mywidgets
          .add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        const SizedBox(
          width: 30,
          child: Text(
            "Pos",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 70,
          child: Text(
            "Jugador",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 60,
          alignment: Alignment.center,
          child: const Text(
            "Goles",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.center,
          child: const Text(
            "PJ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ]));
      mywidgets.add(const Divider(
        thickness: 2,
      ));
      for (int x = 0; x < clasificacion.length; x++) {
        mywidgets.add(FutureBuilder<Socio?>(
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
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        user.alias != ""
                            ? user.alias.toString()
                            : (user.nombre.toString()),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].goles.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        clasificacion[x].partidosJugados.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("");
              }
            }));
        mywidgets.add(const Divider());
      }
      return mywidgets;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
            width: screenWidth,
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
                  "BOTA DE ORO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded)
              ],
            )),
        Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE0DEE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: 
              StreamBuilder<List<Estadisticas>>(
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
              ),),
            const SizedBox(height: 20,),
            Container(
            width: screenWidth,
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
                  "PUNTOS POR PARTIDO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded),                
              ],
            )),
        Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE0DEE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: 
              StreamBuilder<List<Estadisticas>>(
                stream: leerClasificacion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final clasificacion = snapshot.data!;
                    return Column(
                      children: buildPuntosPartido(clasificacion),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),),

          const SizedBox(height: 20,),
            Container(
            width: screenWidth,
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
                  "GOLES POR PARTIDO",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.sports_soccer_rounded),
                Icon(Icons.sports_soccer_rounded),                
              ],
            )),
        Container(
            width: screenWidth,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffE0DEE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: 
              StreamBuilder<List<Estadisticas>>(
                stream: leerClasificacion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final clasificacion = snapshot.data!;
                    return Column(
                      children: buildGolesPartido(clasificacion),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),),
                    
      ],
    );
  }
}
