import 'package:cloud_firestore/cloud_firestore.dart';

class Cliente {
  String nombre;
  String apellido;
  String dni;
  String direccion;
  String telefono;
  String email;
  String nombregym;
  String admin;
  String token;
  String ultimopago;
  String fechavencimiento;
  int estadopago;

  Cliente(
      {required this.nombre,
      required this.apellido,
      required this.dni,
      required this.direccion,
      required this.telefono,
      required this.email,
      required this.nombregym,
      required this.admin,
      required this.token,
      required this.ultimopago,
      required this.fechavencimiento,
      required this.estadopago});

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'apellido': apellido,
        'dni': dni,
        'direccion': direccion,
        'telefono': telefono,
        'email': email,
        'nombregym': nombregym,
        'admin': admin,
        'token': token,
        'ultimopago': ultimopago,
        'fechavencimiento': fechavencimiento,
        'estadopago': estadopago,
      };

  set setnombre(String nombre) {
    this.nombre = nombre;
  }

  set setapellido(String apellido) {
    this.apellido = apellido;
  }

  set setdni(String dni) {
    this.dni = dni;
  }

  set setdirreccion(String direccion) {
    this.direccion = direccion;
  }

  set settelefono(String telefono) {
    this.telefono = telefono;
  }

  set setemail(String email) {
    this.email = email;
  }

  set setgym(String nombregym) {
    this.nombregym = nombregym;
  }

  set setadmin(String admin) {
    this.admin = admin;
  }

  set settoken(String token) {
    this.token = token;
  }

  set setultimopago(String ultimopago) {
    this.ultimopago = ultimopago;
  }

  set setfechavencimiento(String fechavencimiento) {
    this.fechavencimiento = fechavencimiento;
  }

  set setestadopago(int estadopago) {
    this.estadopago = estadopago;
  }

  String get getnombre => this.nombre;
  String get getapellido => this.apellido;
  String get getdni => this.dni;
  String get getdireccion => this.direccion;
  String get gettelefono => this.telefono;
  String get getemail => this.email;
  String get getnombregym => this.nombregym;
  String get getadmin => this.admin;
  String get gettoken => this.token;
  String get getultimopago => this.ultimopago;
  String get getfechavencimiento => this.fechavencimiento;
  int get getestadopago => this.estadopago;

  Cliente.fromSnapshot(DocumentSnapshot snapshot)
      : nombre = snapshot["nombre"],
        apellido = snapshot["apellido"],
        dni = snapshot["dni"],
        direccion = snapshot["direccion"],
        telefono = snapshot["telefono"],
        email = snapshot["email"],
        nombregym = snapshot["nombregym"],
        admin = snapshot["admin"],
        token = snapshot["token"],
        ultimopago = snapshot["ultimopago"],
        fechavencimiento = snapshot["fechavencimiento"],
        estadopago = snapshot["estadopago"];
}
