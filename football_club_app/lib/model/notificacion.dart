class Notificacion {
  String? descripcion;
  String? emisor;
  DateTime? fechaEnvio;
  late bool leida = false;


  Notificacion(
    this.descripcion,
    this.emisor,
    this.fechaEnvio,
  );

  setDescripcion(String descripcion){
    this.descripcion=descripcion;        
  }

  setEmisor(String emisor){
    this.emisor = emisor;
  }

  setFechaEnvio(DateTime fecha){
    fechaEnvio = fecha;
  }  

  marcarComoLeida (){
    leida = true;
  }


  

}
