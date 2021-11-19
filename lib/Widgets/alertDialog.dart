import 'dart:ui';
import 'package:flutter/material.dart';

class AlertaDialogo extends StatelessWidget {
  String titulo = "";
  String contenido = "";
  late VoidCallback contCallBack;

  AlertaDialogo(this.titulo, this.contenido, this.contCallBack);
  TextStyle estiloTexto = TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: new Text(
          titulo,
          style: estiloTexto,
        ),
        content: new Text(
          contenido,
          style: estiloTexto,
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text("Ok"),
            onPressed: () {
              contCallBack();
            },
          ),
          new TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
