import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_club_app/controller/controlador.dart';
import 'package:football_club_app/model/carta.dart';
import 'package:football_club_app/view/home.dart';
import 'package:football_club_app/view/perfil.dart';

class Rating {
  final String name;
  final int value;

  const Rating(this.name, this.value);
}

class TusEstadisticas extends StatefulWidget {
  const TusEstadisticas({super.key});

  @override
  State<TusEstadisticas> createState() => _TusEstadisticasState();
}

class _TusEstadisticasState extends State<TusEstadisticas> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final usuarioActivo = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "TUS ESTADISTICAS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: const Color(0xff2B4EA1),
        body: Center(
            child: Container(
                // height: 780,
                // width: 370,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffffffff),
                ),
                child: ListView(
                  children: [
                    FutureBuilder<Carta?>(
                        future: leerCartaSocio(usuarioActivo.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final jugador = snapshot.data;
                            if (jugador == null) {
                              return const Center(
                                child: Text("nono"),
                              );
                            } else {                              
                              return Column(
                                //alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                      // color: Colors.amber,
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 30, 40, 0),
                                      alignment: Alignment.centerRight,
                                      height: 450,
                                      width:
                                          screenWidth > 430 ? 500 : screenWidth,
                                      child: Center(
                                        child: Hexagon(
                                          screenWidth: screenWidth > 430
                                              ? 430
                                              : screenWidth / 1.25,
                                          jugador: jugador,
                                        ),
                                      )),
                                  Container(
                                    // color: Colors.amber,
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 30, 40, 0),
                                    alignment: Alignment.centerRight,
                                    height: 500,
                                    width: screenWidth,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: buildStats(jugador, context,
                                            usuarioActivo.toString()),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                          } else {                            
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ))));
  }
}

List<Widget> buildStats(
    Carta carta, BuildContext context, String usuarioActivo) {
  List<Widget> ratingRow = [];
  final screenWidth = MediaQuery.of(context).size.width;
  final jugador = [
    Rating("RITMO", carta.ritmo),
    Rating("TIRO", carta.tiro),
    Rating("PASE", carta.pase),
    Rating("REGATE", carta.regate),
    Rating("DEFENSA", carta.defensa),
    Rating("FISICO", carta.fisico),
  ];

  List<TextEditingController> controladores = [
    TextEditingController(text: carta.ritmo.toString()),
    TextEditingController(text: carta.tiro.toString()),
    TextEditingController(text: carta.pase.toString()),
    TextEditingController(text: carta.regate.toString()),
    TextEditingController(text: carta.defensa.toString()),
    TextEditingController(text: carta.fisico.toString()),
  ];

  final ButtonStyle styleInic = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      backgroundColor: const Color(0xff3C3577),
      padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0),
      fixedSize: Size.fromWidth(screenWidth > 430 ? 500 : screenWidth));
  for (int i = 0; i < 6; i += 2) {
    ratingRow.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      SizedBox(
          width: 80,
          child: Text(
            jugador[i].name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff5C5858),
                fontSize: 16),
          )),
      const SizedBox(
        width: 20,
      ),
      SizedBox(
        width: 22,
        child: TextFormField(
          controller: controladores[i],
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2)
          ],
          keyboardType: TextInputType.number,
        ),
      ),
      const SizedBox(
        width: 40,
      ),
      SizedBox(
          width: 80,
          child: Text(
            jugador[i + 1].name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff5C5858),
                fontSize: 16),
          )),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 20,
        child: TextFormField(
          controller: controladores[i + 1],
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2)
          ],
          keyboardType: TextInputType.number,
        ),
      )
    ]));
  }
  ratingRow.add(
    const SizedBox(
      height: 20,
    ),
  );
  ratingRow.add(
    ElevatedButton(
      onPressed: () async {
        final docSocio = FirebaseFirestore.instance
            .collection('estadisticas')
            .doc(usuarioActivo);
        try {
          for (int i = 0; i < controladores.length; i++) {
            docSocio.update({
              jugador[i].name.toLowerCase():
                  int.parse(controladores[i].text.trim()),
            });
          }
        } on FirebaseException catch (e) {
          final snackBar = SnackBar(
            content: Text(e.message.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        const snackBar = SnackBar(
          content: Text('Estadisticas personales actualizadas'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      style: styleInic,
      child: const Center(child: Text("Guardar cambios")),
    ),
  );
  ratingRow.add(
    const SizedBox(
      height: 20,
    ),
  );

  return ratingRow;
}

class Hexagon extends StatelessWidget {
  const Hexagon({Key? key, required this.screenWidth, required this.jugador})
      : super(key: key);
  final double screenWidth;
  final Carta jugador;

  double get diameter => screenWidth / 1.25 - 85;
  double get radius => diameter / 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Labels(radius: radius, diameter: diameter, rating: jugador),
        CustomPaint(
          painter: HexagonPainter(radius: radius),
        ),
        ClipPath(
          clipper: HexagonClipper(radius: radius, multipliers: [
            jugador.ritmo / 100,
            jugador.tiro / 100,
            jugador.pase / 100,
            jugador.regate / 100,
            jugador.defensa / 100,
            jugador.fisico / 100,
          ]),
          child: SizedBox(
            width: diameter,
            height: diameter,
            child: ColoredBox(
              color: Colors.blueAccent.withOpacity(0.7),
            ),
          ),
        )
      ],
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  final double radius;
  final List<double> multipliers;

  HexagonClipper({required this.radius, required this.multipliers});

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.width / 2);
    final Path path = Path();

    // final angleMul = [1, 3, 5, 7, 9, 11, 1];

    path.addPolygon([
      Offset(
        radius * multipliers[0] * cos(pi * 2 * 30 / 360) + center.dx,
        radius * multipliers[0] * sin(pi * 2 * 30 / 360) + center.dy,
      ),
      Offset(
        radius * multipliers[1] * cos(pi * 2 * 90 / 360) + center.dx,
        radius * multipliers[1] * sin(pi * 2 * 90 / 360) + center.dy,
      ),
      Offset(
        radius * multipliers[2] * cos(pi * 2 * 150 / 360) + center.dx,
        radius * multipliers[2] * sin(pi * 2 * 150 / 360) + center.dy,
      ),
      Offset(
        radius * multipliers[3] * cos(pi * 2 * 210 / 360) + center.dx,
        radius * multipliers[3] * sin(pi * 2 * 210 / 360) + center.dy,
      ),
      Offset(
        radius * multipliers[4] * cos(pi * 2 * 270 / 360) + center.dx,
        radius * multipliers[4] * sin(pi * 2 * 270 / 360) + center.dy,
      ),
      Offset(
        radius * multipliers[5] * cos(pi * 2 * 330 / 360) + center.dx,
        radius * multipliers[5] * sin(pi * 2 * 330 / 360) + center.dy,
      ),
    ], true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Labels extends StatelessWidget {
  final double radius, diameter;
  final Carta rating;

  const Labels(
      {super.key,
      required this.radius,
      required this.diameter,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    final center = Offset(diameter / 2 + 80, diameter / 2 + 80);
    final style = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.w600);
    const textAlign = TextAlign.center;
    return Stack(
      children: [
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 30 / 360) + center.dx + 40,
                  radius * sin(pi * 2 * 30 / 360) + center.dy,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "RITMO",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.ritmo.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            )),
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 90 / 360) + center.dx,
                  radius * sin(pi * 2 * 90 / 360) + center.dy + 30,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "TIRO",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.tiro.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            )),
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 150 / 360) + center.dx - 40,
                  radius * sin(pi * 2 * 150 / 360) + center.dy,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "PASE",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.pase.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            )),
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 210 / 360) + center.dx - 40,
                  radius * sin(pi * 2 * 210 / 360) + center.dy,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "REGATE",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.regate.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            )),
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 270 / 360) + center.dx,
                  radius * sin(pi * 2 * 270 / 360) + center.dy - 30,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "DEFENSA",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.defensa.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            )),
        Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(
                  radius * cos(pi * 2 * 330 / 360) + center.dx + 40,
                  radius * sin(pi * 2 * 330 / 360) + center.dy,
                ),
                width: 100,
                height: 40),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "FISICO",
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating.fisico.toString(),
                    textAlign: textAlign,
                    style: style,
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class HexagonPainter extends CustomPainter {
  HexagonPainter({required this.radius});
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint borderPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.blueGrey.withOpacity(0.5)
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.width / 2);
    final angleMul = [1, 3, 5, 7, 9, 11, 1];
    for (int j = 1; j <= 5; j++) {
      for (int i = 0; i < 6; i++) {
        canvas.drawLine(
            Offset(
              j / 5 * radius * cos(pi * 2 * (angleMul[i] * 30 / 360)) +
                  center.dx,
              j / 5 * radius * sin(pi * 2 * (angleMul[i] * 30 / 360)) +
                  center.dy,
            ),
            Offset(
              j / 5 * radius * cos(pi * 2 * (angleMul[i + 1] * 30 / 360)) +
                  center.dx,
              j / 5 * radius * sin(pi * 2 * (angleMul[i + 1] * 30 / 360)) +
                  center.dy,
            ),
            borderPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
