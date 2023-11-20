class Venta {
  int? idVenta;
  String numeroFactura;
  DateTime fecha;
  double precioVenta; // Agrega el campo precioVenta
  int? idCliente;
  String email;


  Venta({
    this.idVenta,
    required this.numeroFactura,
    required this.fecha,
    required this.precioVenta,
    required this.idCliente,
    required this.email,

  });

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        idVenta: json['idVenta'],
        numeroFactura: json['numeroFactura'],
        fecha: DateTime.parse(json['fecha']),
        precioVenta: json['precioVenta'] != null ? json['precioVenta'].toDouble() : 0.0, // Verifica y convierte el valor a double
        idCliente: json['idCliente'],
        email: json['email'],

      );

  Map<String, dynamic> toJson() => {
        'idVenta': idVenta,
        'numeroFactura': numeroFactura,
        'fecha': fecha.toIso8601String(), // Convierte la fecha a String
        'precioVenta': precioVenta,
        'idCliente': idCliente,
        'email': email,

      };
}