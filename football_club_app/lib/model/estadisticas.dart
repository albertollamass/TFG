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

  setPartidosJugados(int pj){
    partidosJugados = pj;
  }

  setPartidosPerdidos(int pp){
    partidosPerdidos = pp;
  }

  setPartidosEmpatados(int pe){
    partidosEmpatados = pe;
  }

  setPartidosGanados(int pg){
    partidosGanados = pg;
  }

  setPuntos(int pts){
    puntos = pts;
  }

  setGoles(int goles){
    this.goles = goles;
  }
  


  Estadisticas copyWith({
    String? email,
    int? partidosJugados,
    int? partidosPerdidos,
    int? partidosEmpatados,
    int? partidosGanados,
    int? puntos,
    int? goles,
  }) {
    return Estadisticas(
      email: email ?? this.email,
      partidosJugados: partidosJugados ?? this.partidosJugados,
      partidosPerdidos: partidosPerdidos ?? this.partidosPerdidos,
      partidosEmpatados: partidosEmpatados ?? this.partidosEmpatados,
      partidosGanados: partidosGanados ?? this.partidosGanados,
      puntos: puntos ?? this.puntos,
      goles: goles ?? this.goles,
    );
  }

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

  @override
  bool operator ==(covariant Estadisticas other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.partidosJugados == partidosJugados &&
      other.partidosPerdidos == partidosPerdidos &&
      other.partidosEmpatados == partidosEmpatados &&
      other.partidosGanados == partidosGanados &&
      other.puntos == puntos &&
      other.goles == goles;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      partidosJugados.hashCode ^
      partidosPerdidos.hashCode ^
      partidosEmpatados.hashCode ^
      partidosGanados.hashCode ^
      puntos.hashCode ^
      goles.hashCode;
  }
}
