
class Socio {
  String nombre;
  String? apellidos;
  String? email;
  int? telefono;
  String? password;
  int? saldo;
  late bool esAdmin = false;

  Socio(
    this.nombre,
    this.apellidos,
    this.email,
    this.telefono,
    this.password,
    this.saldo,
  );

  String getNombre() {
    return nombre;
  }

  String? getApellidos() {
    return apellidos;
  }
  
  String? getEmail() {
    return email;
  }

  int? getTelefono() {
    return telefono;
  }

  String? getPassword() {
    return password;
  }

  int? getSaldo() {
    return saldo;
  }

  setNombre(String nombre){
    this.nombre = nombre;
  }

  setSaldo(int saldo){
    this.saldo = saldo;
  }

  Socio.fromJson(Map<dynamic, dynamic> json)
  : nombre = json['nombre'] as String,
    apellidos = json['apellidos'] as String,
    email = json['email'] as String,
    telefono = json['telefono'],
    password = json['password'] as String,
    saldo = json['saldo'];


  Map<dynamic, dynamic> toJson() => <dynamic, dynamic> {
    'nombre' : nombre.toString(),
    'apellidos' : apellidos.toString(),
    'email' : email.toString(),
    'telefono' : telefono.toString(),
    'password' : password.toString(),
    'saldo' : saldo.toString(),
  };

}
