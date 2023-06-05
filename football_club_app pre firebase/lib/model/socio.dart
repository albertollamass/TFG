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
}
