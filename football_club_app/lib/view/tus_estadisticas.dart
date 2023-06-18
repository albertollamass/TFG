import 'dart:math';

import 'package:flutter/material.dart';

class Rating {
  final String name;
  final int value;

  const Rating(this.name, this.value);
}

const jugador = [
  Rating("RITMO", 87),
  Rating("TIRO", 78),
  Rating("PASE", 94),
  Rating("REGATE", 82),
  Rating("DEFENSA", 56),
  Rating("FISICO", 80),
];

class TusEstadisticas extends StatefulWidget {
  const TusEstadisticas({super.key});

  @override
  State<TusEstadisticas> createState() => _TusEstadisticasState();
}

class _TusEstadisticasState extends State<TusEstadisticas> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle styleInic = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xff3C3577),
        padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 16.0));

    List<Widget> ratingRow = [];

    for (int i = 0; i < 6; i += 2) {
      ratingRow.add(Row(children: [
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
          width: 20,
          child: TextFormField(
            initialValue: jugador[i].value.toString(),
            maxLength: 2,
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
          width: 20,
        ),
        SizedBox(
          width: 20,
          child: TextFormField(
            initialValue: jugador[i + 1].value.toString(),
            maxLength: 2,
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
        onPressed: (() async => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TusEstadisticas()),
              )
            }),
        style: styleInic,
        child: const Center(child: Text("Guardar cambios")),
      ),
    );
    ratingRow.add(
      const SizedBox(
        height: 20,
      ),
    );

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
                    Column(
                      //alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
                          alignment: Alignment.centerRight,
                          height: 400,
                          width: screenWidth,
                          child: Hexagon(screenWidth: screenWidth / 1.25),
                        ),
                        // Container(
                        //   height: 100,
                        //   decoration: BoxDecoration(
                        //       color: Color(0xff2B4EA1),
                              
                        //   ),
                        // ),
                        Container(
                          // color: Colors.amber,
                          padding: const EdgeInsets.fromLTRB(50, 30, 40, 0),
                          alignment: Alignment.centerRight,
                          height: 500,
                          width: screenWidth,
                          child: Column(
                            children: ratingRow,
                          ),
                        )
                      ],
                    )
                  ],
                ))));
  }
}

class Hexagon extends StatelessWidget {
  const Hexagon({Key? key, required this.screenWidth}) : super(key: key);
  final double screenWidth;

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
            jugador[0].value / 100,
            jugador[1].value / 100,
            jugador[2].value / 100,
            jugador[3].value / 100,
            jugador[4].value / 100,
            jugador[5].value / 100,
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
  final List<Rating> rating;

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
                    rating[0].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[0].value.toString(),
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
                    rating[1].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[1].value.toString(),
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
                    rating[2].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[2].value.toString(),
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
                    rating[3].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[3].value.toString(),
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
                    rating[4].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[4].value.toString(),
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
                    rating[5].name,
                    textAlign: textAlign,
                    style: style,
                  ),
                  Text(
                    rating[5].value.toString(),
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
