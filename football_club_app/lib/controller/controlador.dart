import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:football_club_app/model/socio.dart';

Future crearSocio(String name, String surname, String? alias, String email,
    String passwd, String? phone, bool? esAdmin, String? oldEmail) async {
  final docSocio = FirebaseFirestore.instance.collection('socios').doc(email);
  // print("pasa esto");
  var intPhone = int.parse(phone.toString());
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
          email: oldEmail.toString(),
          password: "admin0");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
}

Stream<List<Socio>> leerSocios() {
  return FirebaseFirestore.instance.collection('socios').snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Socio.fromJson(doc.data())).toList());
}

Future<Socio> obtenerSocio(String email) async {
  final ref =
      FirebaseFirestore.instance.collection("socios").doc(email).withConverter(
            fromFirestore: Socio.fromFirestore,
            toFirestore: (Socio city, _) => city.toJson(),
          );
  final docSnap = await ref.get();
  final city = docSnap.data(); // Convert to City object
  if (city != null) {
    print(city.alias);
    return city;
  } else {
    return city as Socio;
    print("No such document.");
  }
}

Future<String> _getPassword(String email) async {
  final ref =
      FirebaseFirestore.instance.collection("socios").doc(email).withConverter(
            fromFirestore: Socio.fromFirestore,
            toFirestore: (Socio city, _) => city.toJson(),
          );
  final docSnap = await ref.get();
  final city = docSnap.data(); // Convert to City object
  if (city != null) {
    print(city.alias);
    return city.password.toString();
  } else {
    return "";    
  }
}
