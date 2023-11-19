class DetalleVenta {
  int? idDetalleVenta;
  int? idVenta;
  int? cantidad;
  int? idProducto;
  String nombre_producto;
  double precioProducto; // Agrega el campo precioDetalleVenta

  DetalleVenta({
    this.idDetalleVenta,
    required this.idVenta,
    required this.cantidad,
    required this.idProducto,
    required this.nombre_producto,
    required this.precioProducto,
  });

  factory DetalleVenta.fromJson(Map<String, dynamic> json) => DetalleVenta(
        idDetalleVenta: json['idDetalleVenta'],
        idVenta: json['idVenta'],
        cantidad: json['cantidad'],
        idProducto: json['idProducto'],
        nombre_producto: json['nombre_producto'],
        precioProducto: json['precioProducto'] != null
            ? json['precioProducto'].toDouble()
            : 0.0, // Verifica y convierte el valor a double
      );

  Map<String, dynamic> toJson() => {
        'idDetalleVenta': idDetalleVenta,
        'idVenta': idVenta,
        'cantidad': cantidad,
        'idProducto': idProducto, // Convierte la fecha a String
        'nombre_producto': nombre_producto, // Convierte la fecha a String
        'precioProducto': precioProducto,
      };
}
