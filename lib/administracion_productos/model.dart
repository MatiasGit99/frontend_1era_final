
class Producto {
  int? idProducto;
  String codigo;
  String nombre_producto;
  int idCategoria;
  String categoria_nombre;

  Producto({
    this.idProducto,
    required this.codigo,
    required this.nombre_producto,
    required this.idCategoria,
    required this.categoria_nombre,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        idProducto: json['idProducto'],
        codigo: json['codigo'],
        nombre_producto: json['nombre_producto'],
        idCategoria: json['idCategoria'],
        categoria_nombre: json['categoria_nombre'],
      );

  Map<String, dynamic> toJson() => {
        'idProducto': idProducto,
        'codigo': codigo,
        'nombre_producto': nombre_producto,
        'idCategoria': idCategoria,
        'categoria_nombre': categoria_nombre,

      };
}
