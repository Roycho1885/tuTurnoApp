class Turno {
  String _id;
  String _horacomienzo;
  String _disciplina;
  String _cupo;
  String _cupoalmacenado;
  String _dias;
  int _foto;

  Turno(this._id, this._horacomienzo, this._disciplina, this._cupo,
      this._cupoalmacenado, this._dias, this._foto);


  set id(String id) {
    this._id = id;
  }

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

  set foto(int foto) {
    this._foto = foto;
  }

  String get id => this._id;
  String get horacomienzo => this._horacomienzo;
  String get disciplina => this._disciplina;
  String get cupo => this._cupo;
  String get cupoalmacenado => this._cupoalmacenado;
  String get dias => this._dias;
  int get foto => this._foto;

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
