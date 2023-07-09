// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Estadisticas {

  String email;
  int partidosJugados;
  int partidosPerdidos;
  int partidosEmpatados;
  int partidosGanados;
  int puntos;
  int goles;

  Estadisticas({
    required this.email,
    required this.partidosJugados,
    required this.partidosPerdidos,
    required this.partidosEmpatados,
    required this.partidosGanados,
    required this.puntos,
    required this.goles,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'partidosJugados': partidosJugados,
      'partidosPerdidos': partidosPerdidos,
      'partidosEmpatados': partidosEmpatados,
      'partidosGanados': partidosGanados,
      'puntos': puntos,
      'goles': goles,
    };
  }

  factory Estadisticas.fromMap(Map<String, dynamic> map) {
    return Estadisticas(
      email: map['email'] as String,
      partidosJugados: map['partidosJugados'] as int,
      partidosPerdidos: map['partidosPerdidos'] as int,
      partidosEmpatados: map['partidosEmpatados'] as int,
      partidosGanados: map['partidosGanados'] as int,
      puntos: map['puntos'] as int,
      goles: map['goles'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Estadisticas.fromJson(String source) => Estadisticas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Estadisticas(email: $email, partidosJugados: $partidosJugados, partidosPerdidos: $partidosPerdidos, partidosEmpatados: $partidosEmpatados, partidosGanados: $partidosGanados, puntos: $puntos, goles: $goles)';
  }
}
