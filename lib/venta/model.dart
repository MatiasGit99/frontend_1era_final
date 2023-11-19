class Venta {
  int? idVenta;
  String numeroFactura;
  DateTime fecha;
  double precioVenta; // Agrega el campo precioVenta


  Venta({
    this.idVenta,
    required this.numeroFactura,
    required this.fecha,
    required this.precioVenta,

  });

  factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        idVenta: json['idVenta'],
        numeroFactura: json['numeroFactura'],
        fecha: DateTime.parse(json['fecha']),
        precioVenta: json['precioVenta'] != null ? json['precioVenta'].toDouble() : 0.0, // Verifica y convierte el valor a double
      );

  Map<String, dynamic> toJson() => {
        'idVenta': idVenta,
        'numeroFactura': numeroFactura,
        'fecha': fecha.toIso8601String(), // Convierte la fecha a String
        'precioVenta': precioVenta,
      };
}