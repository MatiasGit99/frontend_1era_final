class Factura {
  int? idFactura;
  int? idVenta;
  String numeroFactura;
  DateTime fecha;
  double precioVenta; // Agrega el campo precioVenta

  Factura({
    this.idFactura,
    required this.idVenta,
    required this.numeroFactura,
    required this.fecha,
    required this.precioVenta,
    // required this.precioProducto,
  });

  factory Factura.fromJson(Map<String, dynamic> json) => Factura(
        idFactura: json['idFactura'],
        idVenta: json['idVenta'],
    numeroFactura: json['numeroFactura'] ?? '', // Asigna una cadena vacía si es nulo
    fecha: json['fecha'] != null ? DateTime.parse(json['fecha']) : DateTime.now(),
        precioVenta: json['precioVenta'] != null
            ? json['precioVenta'].toDouble()
            : 0.0, // Verifica y convierte el valor a double
      );

  Map<String, dynamic> toJson() => {
        'idFactura': idFactura,
        'idVenta': idVenta,
        'numeroFactura': numeroFactura,
        'fecha': fecha.toIso8601String(), // Convierte la fecha a String
        'precioVenta': precioVenta,
      };
}
