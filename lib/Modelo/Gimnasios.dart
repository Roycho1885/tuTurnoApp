import 'package:cloud_firestore/cloud_firestore.dart';

class Gimnasios {
  String nombre;
  String logo;
  String codigoacceso;
  String ubi;
  String fondo;

  Gimnasios(
      {required this.nombre,
      required this.logo,
      required this.codigoacceso,
      required this.ubi,
      required this.fondo});

  set setnombre(String nombre) {
    this.nombre = nombre;
  }

  set setlogo(String logo) {
    this.logo = logo;
  }

  set setcodigoacceso(String codigoacceso) {
    this.codigoacceso = codigoacceso;
  }

  set setubi(String ubi) {
    this.ubi = ubi;
  }

  set setfondo(String fondo) {
    this.fondo = fondo;
  }

  String get getnombre => this.nombre;
  String get getlogo => this.logo;
  String get getcodigoacceso => this.codigoacceso;
  String get getubi => this.ubi;
  String get getfondo => this.fondo;

  factory Gimnasios.fromMap(Map<String, dynamic> data) => Gimnasios(
      nombre: data['nombre'],
      logo: data['logo'],
      codigoacceso: data['codigoacceso'],
      ubi: data['ubi'],
      fondo: data['fondo']);

  // creating a Trip object from a firebase snapshot
  Gimnasios.fromSnapshot(DocumentSnapshot snapshot)
      : nombre = snapshot['nombre'],
        logo = snapshot['logo'],
        codigoacceso = snapshot['codigoacceso'],
        ubi = snapshot['ubi'],
        fondo = snapshot['fondo'];
}
