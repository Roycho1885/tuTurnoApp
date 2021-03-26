class Gimnasios {
  String _nombre;
  String _logo;
  String _codigoacceso;

  Gimnasios(this._nombre, this._logo, this._codigoacceso);

  Gimnasios.vacio();

  set nombre(String nombre) {
    this._nombre = nombre;
  }

  set logo(String logo) {
    this._logo = logo;
  }

  set codigoacceso(String codigoacceso) {
    this._codigoacceso = codigoacceso;
  }

  String get nombre => this._nombre;
  String get logo => this._logo;
  String get codigoacceso => this._codigoacceso;
}
