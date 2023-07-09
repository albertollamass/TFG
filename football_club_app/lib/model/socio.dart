

import 'package:cloud_firestore/cloud_firestore.dart';

class Socio {
  String? nombre;
  String? apellidos;
  String? email;
  int? telefono;
  String? password;
  int? saldo;
  String? alias = "";
  bool? esAdmin = false;

  Socio({
    this.nombre,
    this.apellidos,
    this.email,
    this.telefono,
    this.password,
    this.saldo,
    this.alias,
    this.esAdmin
  }
  );

  Socio.fromJson(Map<String, dynamic> json)
  : nombre = json['nombre'] as String,
    apellidos = json['apellidos'] as String,
    email = json['email'] as String,
    telefono = json['telefono'] as int?,
    password = json['password'] as String,
    saldo = json['saldo'],
    alias = json['alias'] as String,
    esAdmin = json['esAdmin'] as bool;

  Socio.fromJson2(Map<String, dynamic>? json)
  : nombre = json!['nombre'] as String,
    apellidos = json['apellidos'] as String,
    email = json['email'] as String,
    telefono = json['telefono'] as int?,
    password = json['password'] as String,
    saldo = json['saldo'],
    alias = json['alias'] as String,
    esAdmin = json['esAdmin'] as bool;


  Map<String, dynamic> toJson() => <String, dynamic> {
    'nombre' : nombre.toString(),
    'apellidos' : apellidos.toString(),
    'email' : email.toString(),
    'telefono' : telefono,
    'password' : password.toString(),
    'saldo' : saldo,
    'alias' : alias.toString(),
    'esAdmin' : esAdmin,
  };

    factory Socio.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Socio(
      nombre: data!['nombre'] as String,
      apellidos: data['apellidos'] as String,
      email: data['email'] as String,
      telefono: data['telefono'] as int?,
      password: data['password'] as String,
      saldo: data['saldo'],
      alias: data['alias'] as String,
      esAdmin: data['esAdmin'] as bool
    );
  }

}
