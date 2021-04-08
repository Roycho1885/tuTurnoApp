class Rubros {
  final String nombre;

  Rubros({this.nombre});

  factory Rubros.fromMap(Map<String, dynamic> data) =>
      Rubros(nombre: data['nombre']);
}
