import 'package:flutter/material.dart';

class MultipleNoti extends ChangeNotifier {
  List<String> _itemSelec;
  MultipleNoti(this._itemSelec);
  List<String> get itemsSeleccionados => _itemSelec;

  bool siTieneItem(String value) => _itemSelec.contains(value);

  addItem(String value) {
    if (!siTieneItem(value)) {
      _itemSelec.add(value);
      notifyListeners();
    }
  }

  removerItem(String value) {
    if (siTieneItem(value)) {
      _itemSelec.remove(value);
      notifyListeners();
    }
  }
}
