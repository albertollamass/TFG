import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:football_club_app/model/carta.dart';
import 'package:football_club_app/model/gestion_monedero.dart';
import 'package:football_club_app/model/notificacion.dart';
import 'package:football_club_app/model/socio.dart';

Future crearCartaInicial(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('estadisticas').doc(email);
  final carta =
      Carta(defensa: 0, tiro: 0, regate: 0, ritmo: 0, pase: 0, fisico: 0);

  final json = carta.toMap();
  await docSocio.set(json);
}

Future crearSocio(String name, String surname, String? alias, String email,
    String passwd, String? phone, bool? esAdmin, String? oldEmail) async {
  final docSocio = FirebaseFirestore.instance.collection('socios').doc(email);
  // print("pasa esto");
  var intPhone = phone != "" ? int.parse(phone.toString()): 0;
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
  final historial =
    FirebaseFirestore.instance.collection('historial').where("email", isEqualTo: email);
  
  return historial.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => GestionMonedero.fromMap(doc.data()))
          .toList());
}

Stream<List<GestionMonedero>> leerTodosPagos() {
  return FirebaseFirestore.instance.collection('historial').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => GestionMonedero.fromMap(doc.data()))
          .toList());
}

Stream<List<Notificacion>> leerNotificaciones() {
  return FirebaseFirestore.instance.collection('notificaciones').snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Notificacion.fromMap(doc.data()))
          .toList());
}

Stream<List<Notificacion>> leerNotificacionesSocio(String email) {
  final notis =
    FirebaseFirestore.instance.collection('notificaciones').where("receptor", isEqualTo: email);
  
  return notis.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Notificacion.fromMap(doc.data()))
          .toList());
}

Future<Carta?> leerCartaSocio(String email) async {
  final docSocio =
      FirebaseFirestore.instance.collection('estadisticas').doc(email);
  final snapshot = await docSocio.get();

  if (snapshot.exists) {
    return Carta.fromMap(snapshot.data()!);
  }
}

Future addOperacion(int cantidad, List<String> emails) async {
    
    print(emails.length);
    for (int i = 0; i < emails.length; i++){
      final docSocio =
        FirebaseFirestore.instance.collection('historial').doc();
      final operation =
        GestionMonedero(cantidad: cantidad, email: emails[i], fecha: DateTime.now());

      final json = operation.toMap();
      await docSocio.set(json);
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
  final docSocio = FirebaseFirestore.instance.collection('solicitudes').doc(email);
  // print("pasa esto");
  var intPhone = phone != "" ? int.parse(phone.toString()):0;
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

Future enviarNotificacion(String asunto, String descripcion, List<String> emails) async {
  print(emails.length);
    for (int i = 0; i < emails.length; i++){
      var idNow = DateTime.now();
      final docNoti =
        FirebaseFirestore.instance.collection('notificaciones').doc(((idNow.microsecondsSinceEpoch/1000).truncate()).toString());
      final notificacion =
       Notificacion(asunto, descripcion, emails[i], idNow, false);

      final json = notificacion.toMap();
      await docNoti.set(json);
    }
}