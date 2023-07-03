import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Equipo {

  String color;
  DateTime fechaEquipo; 
  List<String> jugadores;

  Equipo({
    required this.color,
    required this.fechaEquipo,
    required this.jugadores,
  });

  

  Equipo copyWith({
    String? color,
    DateTime? fechaEquipo,
    List<String>? jugadores,
  }) {
    return Equipo(
      color: color ?? this.color,
      fechaEquipo: fechaEquipo ?? this.fechaEquipo,
      jugadores: jugadores ?? this.jugadores,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color,
      'fechaEquipo': fechaEquipo.millisecondsSinceEpoch,
      'jugadores': jugadores,
    };
  }

  factory Equipo.fromMap(Map<String, dynamic> map) {
    return Equipo(
      color: map['color'] as String,
      fechaEquipo: DateTime.fromMillisecondsSinceEpoch(map['fechaEquipo'] as int),
      jugadores: List<String>.from(map['jugadores'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Equipo.fromJson(String source) => Equipo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Equipo(color: $color, fechaEquipo: $fechaEquipo, jugadores: $jugadores)';

  @override
  bool operator ==(covariant Equipo other) {
    if (identical(this, other)) return true;
  
    return 
      other.color == color &&
      other.fechaEquipo == fechaEquipo &&
      listEquals(other.jugadores, jugadores);
  }

  @override
  int get hashCode => color.hashCode ^ fechaEquipo.hashCode ^ jugadores.hashCode;
}
