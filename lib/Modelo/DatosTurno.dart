class DatosTurno {
  String _idTurno;
  String _nombre;
  String _apellido;
  String _direccionturno;
  String _dniturno;
  String _cliente;
  String _fecha;
  String _turno;
  String _disciplina;
  String _idturnoseleccionado;

  DatosTurno(
      this._idTurno,
      this._nombre,
      this._apellido,
      this._direccionturno,
      this._dniturno,
      this._cliente,
      this._fecha,
      this._turno,
      this._disciplina,
      this._idturnoseleccionado);

  set idTurno(String idTurno) {
    this._idTurno = idTurno;
  }

  set nombre(String nombre) {
    this._nombre = nombre;
  }

  set apellido(String apellido) {
    this._apellido = apellido;
  }

  set direccionturno(String direccionturno) {
    this._direccionturno = direccionturno;
  }

  set dniturno(String dniturno) {
    this._dniturno = dniturno;
  }

  set cliente(String cliente) {
    this._cliente = cliente;
  }

  set fecha(String fecha) {
    this._fecha = fecha;
  }

  set turno(String turno) {
    this._turno = turno;
  }

  set disciplina(String disciplina) {
    this._disciplina = disciplina;
  }

  set idturnoseleccionado(String idturnoseleccionado) {
    this._idturnoseleccionado = idturnoseleccionado;
  }

  String get idTurno => this._idTurno;
  String get nombre => this._nombre;
  String get apellido => this._apellido;
  String get direccionturno => this._direccionturno;
  String get dniturno => this._dniturno;
  String get cliente => this._cliente;
  String get fecha => this._fecha;
  String get turno => this._turno;
  String get disciplina => this._disciplina;
  String get idturnoseleccionado => this._idturnoseleccionado;

  String toString() =>
      _apellido +
      " " +
      _nombre +
      "\n" +
      _disciplina +
      "\n" +
      _fecha +
      "\n" +
      "Turno " +
      _turno +
      "hs";
}
