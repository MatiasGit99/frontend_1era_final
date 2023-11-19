class Producto {
  int? idProducto;
  String codigo;
  String nombre_producto;
  int idCategoria;
  String categoria_nombre;
  double precioVenta; // Nuevo campo agregado

  Producto({
    this.idProducto,
    required this.codigo,
    required this.nombre_producto,
    required this.idCategoria,
    required this.categoria_nombre,
    required this.precioVenta,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json['idProducto'],
        codigo: json['codigo'],
        nombre_producto: json['nombre_producto'],
        idCategoria: json['idCategoria'],
        categoria_nombre: json['categoria_nombre'],
        precioVenta: json['precioVenta'] != null ? json['precioVenta'].toDouble() : 0.0, // Verifica y convierte el valor a double
      );

  Map<String, dynamic> toJson() => {
        'idProducto': idProducto,
        'codigo': codigo,
        'nombre_producto': nombre_producto,
        'idCategoria': idCategoria,
        'categoria_nombre': categoria_nombre,
        'precioVenta': precioVenta, // Asegúrate de que el nombre coincida con el JSON
      };
}
