// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notificacion {
  String? asunto;
  String? descripcion;
  String? receptor;
  DateTime? fechaEnvio;
  bool leida = false;


  Notificacion(
    this.asunto,
    this.descripcion,
    this.receptor,
    this.fechaEnvio,
    this.leida
  );

  setDescripcion(String descripcion){
    this.descripcion=descripcion;        
  }

  setReceptor(String receptor){
    this.receptor = receptor;
  }

  setFechaEnvio(DateTime fecha){
    fechaEnvio = fecha;
  }  

  marcarComoLeida (){
    leida = true;
  }


  


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'asunto': asunto,
      'descripcion': descripcion,
      'receptor': receptor,
      'fechaEnvio': fechaEnvio?.millisecondsSinceEpoch,
      'leida': leida,
    };
  }

  factory Notificacion.fromMap(Map<String, dynamic> map) {
    return Notificacion(
      map['asunto'] != null ? map['asunto'] as String : null,
      map['descripcion'] != null ? map['descripcion'] as String : null,
      map['receptor'] != null ? map['receptor'] as String : null,
      map['fechaEnvio'] != null ? DateTime.fromMillisecondsSinceEpoch(map['fechaEnvio'] as int) : null,
      map['leida'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notificacion.fromJson(String source) => Notificacion.fromMap(json.decode(source) as Map<String, dynamic>);
}
