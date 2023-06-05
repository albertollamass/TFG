// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:football_club_app/model/socio.dart';

class Estadisticas {

  Socio socio;
  int partidosJugados;
  int partidosPerdidos;
  int partidosEmpatados;
  int partidosGanados;
  int puntos;
  int goles;

  Estadisticas({
    required this.socio,
    required this.partidosJugados,
    required this.partidosPerdidos,
    required this.partidosEmpatados,
    required this.partidosGanados,
    required this.puntos,
    required this.goles,
  });

  setSocio(Socio socio){
    this.socio = socio;
  }

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
  

}
