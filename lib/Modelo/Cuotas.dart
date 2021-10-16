class Cuotas {
  String _clientenombre;
  String _emailcliente;
  String _fechapago;
  String _fechavenc;
  String _mespago;
  int _estadopago;

  Cuotas(this._clientenombre, this._emailcliente, this._fechapago,
      this._fechavenc, this._mespago, this._estadopago);


  set estadopago(int estadopago) {
    this._estadopago = estadopago;
  }

  String get clientenombre => this._clientenombre;
  String get emailcliente => this._emailcliente;
  String get fechapago => this._fechapago;
  String get fechavenc => this._fechavenc;
  String get mespago => this._mespago;
  int get estadopago => this._estadopago;
}
