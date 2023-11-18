class Cliente {
  int? idPersona;
  String nombre;
  String apellido;
  String ruc;
  String email;

  Cliente({
    required this.idPersona,
    required this.nombre,
    required this.apellido,
    required this.ruc,
    required this.email,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idPersona: json['idPersona'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      ruc: json['ruc'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPersona': idPersona,
      'nombre': nombre,
      'apellido': apellido,
      'ruc': ruc,
      'email': email,
    };
  }
}
