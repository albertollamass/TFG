// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'equipo.dart';

class Partido {
  DateTime fechaPartido;
  int golesBlanco;
  int golesNegro;
  Map<String, int> goles;

  //pensando que se puede omitir al tener tbn en equipos la fecha
  Partido({
    required this.fechaPartido,
    required this.golesBlanco,
    required this.golesNegro,
    required this.goles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fechaPartido': fechaPartido.millisecondsSinceEpoch,
      'golesBlanco': golesBlanco,
      'golesNegro': golesNegro,
      'goles': goles,
    };
  }

  factory Partido.fromMap(Map<String, dynamic> map) {
    final golesMap = map['goles'] as Map<String, dynamic>;
    final convertedGoles = <String, int>{};

    golesMap.forEach((key, value) {
      convertedGoles[key] = value as int;
    });

    return Partido(
      fechaPartido:
          DateTime.fromMillisecondsSinceEpoch(map['fechaPartido'] as int),
      golesBlanco: map['golesBlanco'] as int,
      golesNegro: map['golesNegro'] as int,
      goles: convertedGoles,
    );
  }

  String toJson() => json.encode(toMap());

  factory Partido.fromJson(String source) =>
      Partido.fromMap(json.decode(source) as Map<String, dynamic>);

  Partido copyWith({
    DateTime? fechaPartido,
    int? golesBlanco,
    int? golesNegro,
    Map<String, int>? goles,
  }) {
    return Partido(
      fechaPartido: fechaPartido ?? this.fechaPartido,
      golesBlanco: golesBlanco ?? this.golesBlanco,
      golesNegro: golesNegro ?? this.golesNegro,
      goles: goles ?? this.goles,
    );
  }

  @override
  String toString() {
    return 'Partido(fechaPartido: $fechaPartido, golesBlanco: $golesBlanco, golesNegro: $golesNegro, goles: $goles)';
  }

  @override
  bool operator ==(covariant Partido other) {
    if (identical(this, other)) return true;

    return other.fechaPartido == fechaPartido &&
        other.golesBlanco == golesBlanco &&
        other.golesNegro == golesNegro &&
        mapEquals(other.goles, goles);
  }

  @override
  int get hashCode {
    return fechaPartido.hashCode ^
        golesBlanco.hashCode ^
        golesNegro.hashCode ^
        goles.hashCode;
  }
}
