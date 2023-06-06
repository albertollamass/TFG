// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'equipo.dart';

class Partido {
  DateTime fechaPartido;
  Map <String, int> resultado;
  List<Equipo> equipos;  
     //pensando que se puede omitir al tener tbn en equipos la fecha
  Partido({
    required this.fechaPartido,
    required this.resultado,
    required this.equipos,
  });

  setFechaPartido(DateTime fechaPartido) {
    this.fechaPartido = fechaPartido;  
  }

  setResultado(Map<String, int> resultado){
    this.resultado = resultado;
  }

  setEquipos(List<Equipo> equipos){
    this.equipos = equipos;
  }
}
