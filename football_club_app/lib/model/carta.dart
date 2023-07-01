// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Carta {
  late int ritmo;
  late int tiro;
  late int pase;
  late int regate;
  late int fisico;
  late int defensa;

  Carta({
    required this.ritmo,
    required this.tiro,
    required this.pase,
    required this.regate,
    required this.fisico,
    required this.defensa    
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ritmo': ritmo,
      'tiro': tiro,
      'pase': pase,
      'regate': regate,
      'fisico': fisico,
      'defensa': defensa,
    };
  }

  factory Carta.fromMap(Map<String, dynamic> map) {
    return Carta(
      ritmo: map['ritmo'] as int,
      tiro: map['tiro'] as int,
      pase: map['pase'] as int,
      regate: map['regate'] as int,
      fisico: map['fisico'] as int,
      defensa: map['defensa'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Carta.fromJson(String source) => Carta.fromMap(json.decode(source) as Map<String, dynamic>);
}
