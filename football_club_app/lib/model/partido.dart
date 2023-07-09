// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Partido {
  DateTime fechaPartido;
  int golesBlanco;
  int golesNegro;
  Map<String, int> goles;
  bool yaEditado;

  Partido({
    required this.fechaPartido,
    required this.golesBlanco,
    required this.golesNegro,
    required this.goles,
    required this.yaEditado
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fechaPartido': fechaPartido.millisecondsSinceEpoch,
      'golesBlanco': golesBlanco,
      'golesNegro': golesNegro,
      'goles': goles,
      'yaEditado': yaEditado,
    };
  }

  factory Partido.fromMap(Map<String, dynamic> map) {
    final golesMap = map['goles'] as Map<String, dynamic>;
    final convertedGoles = <String, int>{};

    golesMap.forEach((key, value) {
      convertedGoles[key] = value as int;
    });
    return Partido(
      fechaPartido: DateTime.fromMillisecondsSinceEpoch(map['fechaPartido'] as int),
      golesBlanco: map['golesBlanco'] as int,
      golesNegro: map['golesNegro'] as int,
      goles: convertedGoles,
      yaEditado: map['yaEditado'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Partido.fromJson(String source) =>
      Partido.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Partido(fechaPartido: $fechaPartido, golesBlanco: $golesBlanco, golesNegro: $golesNegro, goles: $goles, yaEditado: $yaEditado)';
  }

}
