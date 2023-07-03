// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'equipo.dart';

class Partido {
  DateTime fechaPartido;
  int golesBlanco;
  int golesNegro;

  //pensando que se puede omitir al tener tbn en equipos la fecha
  Partido({
    required this.fechaPartido,
    required this.golesBlanco,
    required this.golesNegro,

  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fechaPartido': fechaPartido.millisecondsSinceEpoch,
      'golesBlanco': golesBlanco,
      'golesNegro': golesNegro,
    };
  }

  factory Partido.fromMap(Map<String, dynamic> map) {
    return Partido(
      fechaPartido: DateTime.fromMillisecondsSinceEpoch(map['fechaPartido'] as int),
      golesBlanco: map['golesBlanco'] as int,
      golesNegro: map['golesNegro'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Partido.fromJson(String source) => Partido.fromMap(json.decode(source) as Map<String, dynamic>);
}
