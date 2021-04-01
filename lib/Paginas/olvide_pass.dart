import 'package:flutter/material.dart';

class OlvidePass extends StatefulWidget {
  @override
  _OlvidePassState createState() => _OlvidePassState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
String _email;

Widget _crearCampoEmail() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    enableSuggestions: true,
    decoration: InputDecoration(
      labelText: 'Email',
      prefixIcon: Icon(Icons.email),
    ),
    validator: (String value) {
      if (value.isEmpty) {
        return 'Ingrese Email';
      }
      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return 'Por favor ingrese un email válido';
      }

      return null;
    },
    onSaved: (String value) {
      _email = value;
    },
  );
}

class _OlvidePassState extends State<OlvidePass> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: Center(
        child: (_width > 640) ? _pantallaGrande() : _pantallaChica(),
      ),
    );
  }
}

Widget _pantallaGrande() {
  return Container(
    padding: EdgeInsets.fromLTRB(200, 5, 200, 5),
    child: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _crearCampoEmail(),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 260,
                height: 50,
                child: ElevatedButton(
                  child: Text('Recuperar'),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    _formkey.currentState.save();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _pantallaChica() {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
    child: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _crearCampoEmail(),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 260,
                height: 50,
                child: ElevatedButton(
                  child: Text('Recuperar'),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    _formkey.currentState.save();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
