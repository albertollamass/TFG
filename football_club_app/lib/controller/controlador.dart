import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:football_club_app/model/carta.dart';
import 'package:football_club_app/model/equipo.dart';
import 'package:football_club_app/model/estadisticas.dart';
import 'package:football_club_app/model/gestion_monedero.dart';
import 'package:football_club_app/model/notificacion.dart';
import 'package:football_club_app/model/partido.dart';
import 'package:football_club_app/model/socio.dart';

Future crearCartaInicial(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('estadisticas').doc(email);
  final carta =
      Carta(defensa: 0, tiro: 0, regate: 0, ritmo: 0, pase: 0, fisico: 0);

  final json = carta.toMap();
  await docSocio.set(json);
}

Future crearClasificacion(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);
  final stats = Estadisticas(
      email: email,
      goles: 0,
      partidosEmpatados: 0,
      partidosGanados: 0,
      partidosJugados: 0,
      partidosPerdidos: 0,
      puntos: 0);

  final json = stats.toMap();
  await docSocio.set(json);
}

Future crearSocio(String name, String surname, String? alias, String email,
    String passwd, String? phone, bool? esAdmin, String? oldEmail) async {
  final docSocio = FirebaseFirestore.instance.collection('socios').doc(email);
  // print("pasa esto");
  var intPhone = phone != "" ? int.parse(phone.toString()) : 0;
  final socio = Socio(
      nombre: name,
      apellidos: surname,
      email: email,
      telefono: intPhone,
      password: passwd,
      saldo: 0,
      alias: alias,
      esAdmin: esAdmin as bool);

  final json = socio.toJson();

  await docSocio.set(json);

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: passwd);
  } on FirebaseException catch (e) {
    print(e);
  }
  FirebaseAuth.instance.signOut();
  // Future<String> oldPasswd = _getPassword(oldEmail.toString());
  // print("$oldEmail $oldPasswd");

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: oldEmail.toString(), password: "admin0");
  } on FirebaseAuthException catch (e) {
    print(e);
  }

  crearCartaInicial(email);
  crearClasificacion(email);
}

Stream<List<Socio>> leerSocios() {
  return FirebaseFirestore.instance.collection('socios').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Socio.fromJson(doc.data())).toList());
}

Future<Socio?> leerSocio(String email) async {
  final docSocio = FirebaseFirestore.instance.collection('socios').doc(email);
  final snapshot = await docSocio.get();

  if (snapshot.exists) {
    return Socio.fromJson(snapshot.data()!);
  }
}

Stream<List<GestionMonedero>> leerPagosSocio(String email) {
  final historial = FirebaseFirestore.instance
      .collection('historial')
      .where("email", isEqualTo: email);

  return historial.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => GestionMonedero.fromMap(doc.data())).toList());
}

Stream<List<GestionMonedero>> leerTodosPagos() {
  return FirebaseFirestore.instance.collection('historial').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => GestionMonedero.fromMap(doc.data()))
          .toList());
}

Stream<List<Notificacion>> leerNotificaciones() {
  return FirebaseFirestore.instance
      .collection('notificaciones')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Notificacion.fromMap(doc.data()))
          .toList());
}

Stream<List<Notificacion>> leerNotificacionesSocio(String? email) {
  final notis = FirebaseFirestore.instance
      .collection('notificaciones')
      .where("receptor", isEqualTo: email);

  return notis.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Notificacion.fromMap(doc.data())).toList());
}

Future<Carta?> leerCartaSocio(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('estadisticas').doc(email);
  final snapshot = await docSocio.get();

  if (snapshot.exists) {
    return Carta.fromMap(snapshot.data()!);
  }
}

Stream<List<Partido>> leerUltimoPartido() {
  final docSocio =
      FirebaseFirestore.instance.collection('partidos').snapshots();

  return docSocio.map((snapshot) =>
      snapshot.docs.map((doc) => Partido.fromMap(doc.data())).toList());
}

Future addOperacion(int cantidad, List<String> emails) async {
  print(emails.length);
  for (int i = 0; i < emails.length; i++) {
    final docHistSocio =
        FirebaseFirestore.instance.collection('historial').doc();
    final operation = GestionMonedero(
        cantidad: cantidad, email: emails[i], fecha: DateTime.now());

    final json = operation.toMap();
    await docHistSocio.set(json);

    final docSocio =
        FirebaseFirestore.instance.collection('socios').doc(emails[i]);

    DocumentSnapshot snapshot = await docSocio.get();

    if (snapshot.exists) {
      // Access the value of a specific field
      int saldo = snapshot['saldo'];
      docSocio.update({
        'saldo': saldo + cantidad,
      });
    }
  }
}

bool comprobarPass(String oldPass, String newPass) {
  if (oldPass == newPass) {
    return true;
  } else {
    return false;
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

Future crearSolicitud(String name, String surname, String? alias, String email,
    String passwd, String? phone, bool? esAdmin) async {
  final docSocio =
      FirebaseFirestore.instance.collection('solicitudes').doc(email);
  // print("pasa esto");
  var intPhone = phone != "" ? int.parse(phone.toString()) : 0;
  final socio = Socio(
      nombre: name,
      apellidos: surname,
      email: email,
      telefono: intPhone,
      password: passwd,
      saldo: 0,
      alias: alias,
      esAdmin: esAdmin as bool);

  final json = socio.toJson();

  await docSocio.set(json);
}

Stream<List<Socio>> leerSolicitudes() {
  return FirebaseFirestore.instance.collection('solicitudes').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Socio.fromJson(doc.data())).toList());
}

Future enviarNotificacion(
    String asunto, String descripcion, List<String> emails) async {
  print(emails.length);
  for (int i = 0; i < emails.length; i++) {
    var idNow = DateTime.now();
    final docNoti = FirebaseFirestore.instance
        .collection('notificaciones')
        .doc(((idNow.microsecondsSinceEpoch / 1000).truncate()).toString());
    final notificacion =
        Notificacion(asunto, descripcion, emails[i], idNow, false);

    final json = notificacion.toMap();
    await docNoti.set(json);
  }
}

Stream<List<Partido>> leerPartidos() {
  return FirebaseFirestore.instance.collection('partidos').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Partido.fromMap(doc.data())).toList());
}

Future crearEquipo(Equipo equipo1, Equipo equipo2) async {
  final docSocio = FirebaseFirestore.instance
      .collection('equipos')
      .doc("${equipo1.color}_${equipo1.fechaEquipo}");
  final docSocio2 = FirebaseFirestore.instance
      .collection('equipos')
      .doc("${equipo2.color}_${equipo2.fechaEquipo}");

  final json2 = equipo2.toMap();
  final json = equipo1.toMap();

  await docSocio2.set(json2);
  await docSocio.set(json);
}

Future crearPartido(DateTime fecha) async {
  final docSocio = FirebaseFirestore.instance
      .collection('partidos')
      .doc(fecha.millisecondsSinceEpoch.toString());

  Partido partido = Partido(
      fechaPartido: fecha,
      golesBlanco: 0,
      golesNegro: 0,
      goles: {},
      yaEditado: false);

  final json = partido.toMap();

  await docSocio.set(json);
}

Stream<List<Equipo>> leerEquiposPartido(DateTime fecha) {
  return FirebaseFirestore.instance
      .collection('equipos')
      .where("fechaEquipo", isEqualTo: fecha.millisecondsSinceEpoch)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Equipo.fromMap(doc.data())).toList());
}

Future actualizarGolesJugador(String email, String goles) async {
  //actualizar en clasificacion
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);

  DocumentSnapshot snapshot = await docSocio.get();

  if (snapshot.exists) {
    // Access the value of a specific field
    int fieldValue = snapshot['goles'];
    docSocio.update({'goles': fieldValue + int.parse(goles)});
  }
  //actualizar en partido
}

Future actualizarPartidosGanador(String email) async {
  //actualizar en clasificacion
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);

  DocumentSnapshot snapshot = await docSocio.get();

  if (snapshot.exists) {
    // Access the value of a specific field
    int pj = snapshot['partidosJugados'];
    int pg = snapshot['partidosGanados'];
    int pts = snapshot['puntos'];
    docSocio.update({
      'partidosJugados': pj + 1,
      'partidosGanados': pg + 1,
      'puntos': pts + 3
    });
  }
  //actualizar en partido
}

Future actualizarPartidosPerdedor(String email) async {
  //actualizar en clasificacion
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);

  DocumentSnapshot snapshot = await docSocio.get();

  if (snapshot.exists) {
    // Access the value of a specific field
    int pj = snapshot['partidosJugados'];
    int pp = snapshot['partidosPerdidos'];
    docSocio.update({
      'partidosJugados': pj + 1,
      'partidosPerdidos': pp + 1,
    });
  }
  //actualizar en partido
}

Future actualizarPartidosEmpate(String email) async {
  //actualizar en clasificacion
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);

  DocumentSnapshot snapshot = await docSocio.get();

  if (snapshot.exists) {
    int pj = snapshot['partidosJugados'];
    int pe = snapshot['partidosEmpatados'];
    int pts = snapshot['puntos'];
    docSocio.update({
      'partidosJugados': pj + 1,
      'partidosEmpatados': pe + 1,
      'puntos': pts + 1
    });
  }
  //actualizar en partido
}

Future<Estadisticas?> getEstadisticasSocio(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('clasificacion').doc(email);
  final snapshot = await docSocio.get();

  if (snapshot.exists) {
    return Estadisticas.fromMap(snapshot.data()!);
  }
}

Stream<List<Estadisticas>> leerClasificacion() {
  return FirebaseFirestore.instance.collection('clasificacion').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Estadisticas.fromMap(doc.data()))
          .toList());
}

// Future crearEstadisticasAleatorias(List<String> emails) async {

//   for (int i = 0; i < emails.length; i++) {
//     final docStats = FirebaseFirestore.instance.collection('estadisticas').doc(emails[i]);
//     final ss = await docStats.get();

//     if (ss.exists){
//       docStats.update({
//         'defensa' : 30 + Random().nextInt(90 - 30 + 1),
//         'fisico' : 30 + Random().nextInt(90 - 30 + 1),
//         'tiro': 30 + Random().nextInt(90 - 30 + 1),
//         'pase': 30 + Random().nextInt(90 - 30 + 1),
//         'regate': 30 + Random().nextInt(90 - 30 + 1),
//         'ritmo': 30 + Random().nextInt(90 - 30 + 1),
//       });
//     }
//   }

// }

Future generarEquiposAleatorios(List<String> emails, DateTime fecha) async {
  Map<String, double> jugadores = {};
  emails.remove("admin@gmail.com");
  emails.shuffle();

  for (int i = 0; i < emails.length; i++) {
    final docStats =
        FirebaseFirestore.instance.collection('estadisticas').doc(emails[i]);
    final ss = await docStats.get();
    final docSocio =
        FirebaseFirestore.instance.collection('clasificacion').doc(emails[i]);

    DocumentSnapshot snapshot = await docSocio.get();
    int pj = 0;
    int pe = 0;
    int pg = 0;
    int pp = 0;
    int goles = 0;
    if (snapshot.exists) {
      pj = snapshot['partidosJugados'];
      pe = snapshot['partidosEmpatados'];
      pg = snapshot['partidosGanados'];
      pp = snapshot['partidosPerdidos'];
      goles = snapshot['goles'];
    }

    if (ss.exists) {
      double media = (ss['defensa'] +
              ss['fisico'] +
              ss['tiro'] +
              ss['pase'] +
              ss['regate'] +
              ss['ritmo']) /
          6;
      double relacionPartidos = (pg - pp) / (pe + 1);
      double promedioGoles = goles / (pj + 1);
      final jugador = <String, double>{
        emails[i]: (media * relacionPartidos * promedioGoles)
      };
      jugadores.addEntries(jugador.entries);
    }
  }

  double mediaGlobal = calcularMediaGlobal(jugadores);

  Map<String, double> equipoNegro = {};
  Map<String, double> equipoBlanco = {};
  List<String> jugNeg = [];
  List<String> jugBlanco = [];
  // Divide a los jugadores en dos equipos equilibrados
  for (int i = 0; i < jugadores.length; i++) {
    if (equipoNegro.length < 6 &&
        (calcularMediaGlobal({
              ...equipoNegro,
              ...{jugadores.keys.elementAt(i): jugadores.values.elementAt(i)}
            }) <=
            mediaGlobal)) {
      final jugador = <String, double>{
        jugadores.keys.elementAt(i): jugadores.values.elementAt(i)
      };
      equipoNegro.addEntries(jugador.entries);
      jugNeg.add(jugadores.keys.elementAt(i));
    } else {
      final jugador = <String, double>{
        jugadores.keys.elementAt(i): jugadores.values.elementAt(i)
      };
      equipoBlanco.addEntries(jugador.entries);
      jugBlanco.add(jugadores.keys.elementAt(i));
    }
  }

  Equipo negro = Equipo(color: "negro", fechaEquipo: fecha, jugadores: jugNeg);
  Equipo blanco =
      Equipo(color: "blanco", fechaEquipo: fecha, jugadores: jugBlanco);

  crearEquipo(negro, blanco);
}

// Calcula el promedio de las estadísticas de los jugadores en una lista
double calcularMediaGlobal(Map<String, double> jugadores) {
  double totalStats = 0;
  for (int i = 0; i < jugadores.length; i++) {
    totalStats += jugadores.values.elementAt(i);
  }
  return totalStats / jugadores.length;
}

Future cobrarMensualidad(List<String> emails) async {
  addOperacion(-20, emails);
}
