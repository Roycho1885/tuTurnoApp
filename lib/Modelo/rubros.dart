class Rubros {
  final String nombre;

  Rubros({required this.nombre});

  factory Rubros.fromMap(Map<String, dynamic> data) =>
      Rubros(nombre: data['nombre']);
}
