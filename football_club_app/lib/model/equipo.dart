// ignore_for_file: public_member_api_docs, sort_constructors_first
class Equipo {

  String color;
  DateTime fechaEquipo; //Fecha en la que se jugó con dicho equipo, si se repiten los equipos, se queda con la mas reciente
  List<String> jugadores;

  Equipo({
    required this.color,
    required this.fechaEquipo,
    required this.jugadores,
  });

  setColor(String color) {
    this.color = color;
  }

  setFecha(DateTime fechaEquipo) {
    this.fechaEquipo = fechaEquipo;
  }

  setJugadores(List<String> jugadores) {
    this.jugadores = jugadores;
  }
  
}
