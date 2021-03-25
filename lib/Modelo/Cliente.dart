class Cliente {
  String _id;
  String _nombre;
  String _apellido;
  String _dni;
  String _direccion;
  String _email;
  String _gym;
  String _admin;
  String _token;
  String _ultimopago;
  String _fechavencimiento;
  int _estadopago;

  Cliente(
      this._id,
      this._nombre,
      this._apellido,
      this._dni,
      this._direccion,
      this._email,
      this._gym,
      this._admin,
      this._token,
      this._ultimopago,
      this._fechavencimiento,
      this._estadopago);

  Cliente.vacio();

  Cliente.modi1(this._apellido, this._nombre, this._ultimopago,
      this._fechavencimiento, this._estadopago);

  set id(String id) {
    this._id = id;
  }

  set nombre(String nombre) {
    this._nombre = nombre;
  }

  set apellido(String apellido) {
    this._apellido = apellido;
  }

  set dni(String dni) {
    this._dni = dni;
  }

  set dirreccion(String direccion) {
    this._direccion = direccion;
  }

  set email(String email) {
    this._email = email;
  }

  set gym(String gym) {
    this._gym = gym;
  }

  set admin(String admin) {
    this._admin = admin;
  }

  set token(String token) {
    this._token = token;
  }

  set ultimopago(String ultimopago) {
    this._ultimopago = ultimopago;
  }

  set fechavencimiento(String fechavencimiento) {
    this._fechavencimiento = fechavencimiento;
  }

  set estadopago(int estadopago) {
    this._estadopago = estadopago;
  }

  String get id => this._id;
  String get nombre => this._nombre;
  String get apellido => this._apellido;
  String get dni => this._dni;
  String get direccion => this._direccion;
  String get email => this._email;
  String get gym => this._gym;
  String get admin => this._admin;
  String get token => this._token;
  String get ultimopago => this._ultimopago;
  String get fechavencimiento => this._fechavencimiento;
  int get estadopago => this._estadopago;

  String toString() => _apellido + " " + _nombre + "\n" + "Admin " + _admin;
}
