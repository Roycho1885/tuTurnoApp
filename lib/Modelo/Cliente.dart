class Cliente {
  String _nombre;
  String _apellido;
  String _dni;
  String _direccion;
  String _email;
  String _rubronombre;
  String _admin;
  String _token;
  String _ultimopago;
  String _fechavencimiento;
  String _catnombre;
  int _estadopago;

  Cliente(
      this._nombre,
      this._apellido,
      this._dni,
      this._direccion,
      this._email,
      this._rubronombre,
      this._admin,
      this._token,
      this._ultimopago,
      this._fechavencimiento,
      this._catnombre,
      this._estadopago);

  Cliente.vacio();

  Cliente.modi1(this._apellido, this._nombre, this._ultimopago,
      this._fechavencimiento, this._estadopago);

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'apellido': apellido,
        'dni': dni,
        'direccion': direccion,
        'email': email,
        'rubronombre': rubronombre,
        'admin': admin,
        'token': token,
        'ultimopago': ultimopago,
        'fechavencimiento': fechavencimiento,
        'catnombre': catnombre,
        'estadopago': estadopago,
      };

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

  set gym(String rubronombre) {
    this._rubronombre = rubronombre;
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

  set catnombre(String catnombre) {
    this._catnombre = catnombre;
  }

  set estadopago(int estadopago) {
    this._estadopago = estadopago;
  }

  String get nombre => this._nombre;
  String get apellido => this._apellido;
  String get dni => this._dni;
  String get direccion => this._direccion;
  String get email => this._email;
  String get rubronombre => this._rubronombre;
  String get admin => this._admin;
  String get token => this._token;
  String get ultimopago => this._ultimopago;
  String get fechavencimiento => this._fechavencimiento;
  String get catnombre => this._catnombre;
  int get estadopago => this._estadopago;

  String toString() => _apellido + " " + _nombre + "\n" + "Admin " + _admin;
}
