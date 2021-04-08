class Gimnasios {
  String nombre;
  String logo;
  String codigoacceso;

  Gimnasios({this.nombre, this.logo, this.codigoacceso});

  Gimnasios.vacio();

  set setnombre(String nombre) {
    this.nombre = nombre;
  }

  set setlogo(String logo) {
    this.logo = logo;
  }

  set setcodigoacceso(String codigoacceso) {
    this.codigoacceso = codigoacceso;
  }

  String get getnombre => this.nombre;
  String get getlogo => this.logo;
  String get getcodigoacceso => this.codigoacceso;

  factory Gimnasios.fromMap(Map<String, dynamic> data) => Gimnasios(
      nombre: data['nombre'],
      logo: data['logo'],
      codigoacceso: data['codigoacceso']);
}
