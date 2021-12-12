class Turno {
  String _disciplina;
  String _horacomienzo;
  String _cupo;
  String _cupoalmacenado;
  String _dias;
  String _entrenador;

  Turno(this._disciplina, this._horacomienzo, this._cupo, this._cupoalmacenado,
      this._dias, this._entrenador);

  Map<String, dynamic> toJson() => {
        'disciplina': _disciplina,
        'horacomienzo': _horacomienzo,
        'cupo': _cupo,
        'cupoalmacenado': _cupoalmacenado,
        'dias': _dias,
      };

  set horacomienzo(String horacomienzo) {
    this._horacomienzo = horacomienzo;
  }

  set disciplina(String disciplina) {
    this._disciplina = disciplina;
  }

  set cupo(String cupo) {
    this._cupo = cupo;
  }

  set cupoalmacenado(String cupoalmacenado) {
    this._cupoalmacenado = cupoalmacenado;
  }

  set dias(String dias) {
    this._dias = dias;
  }

  set entrenador(String entrenador) {
    this._entrenador = entrenador;
  }

  String get horacomienzo => this._horacomienzo;
  String get disciplina => this._disciplina;
  String get cupo => this._cupo;
  String get cupoalmacenado => this._cupoalmacenado;
  String get dias => this._dias;
  String get entrenador => this._entrenador;

  String toString() =>
      "Hora " +
      _horacomienzo +
      "\n" +
      "Cupo " +
      _cupo +
      "\n" +
      "Días " +
      _dias +
      "\n";
}
