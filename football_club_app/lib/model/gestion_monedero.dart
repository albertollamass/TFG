// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GestionMonedero {
  int cantidad;
  String email;
  DateTime fecha;
  
  GestionMonedero({
    required this.cantidad,
    required this.email,
    required this.fecha,
  });

  GestionMonedero copyWith({
    int? cantidad,
    String? email,
    DateTime? fecha,
  }) {
    return GestionMonedero(
      cantidad: cantidad ?? this.cantidad,
      email: email ?? this.email,
      fecha: fecha ?? this.fecha,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cantidad': cantidad,
      'email': email,
      'fecha': fecha.millisecondsSinceEpoch,
    };
  }

  factory GestionMonedero.fromMap(Map<String, dynamic> map) {
    return GestionMonedero(
      cantidad: map['cantidad'] as int,
      email: map['email'] as String,
      fecha: DateTime.fromMillisecondsSinceEpoch(map['fecha'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GestionMonedero.fromJson(String source) => GestionMonedero.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GestionMonedero(cantidad: $cantidad, email: $email, fecha: $fecha)';

  @override
  bool operator ==(covariant GestionMonedero other) {
    if (identical(this, other)) return true;
  
    return 
      other.cantidad == cantidad &&
      other.email == email &&
      other.fecha == fecha;
  }

  @override
  int get hashCode => cantidad.hashCode ^ email.hashCode ^ fecha.hashCode;
}
