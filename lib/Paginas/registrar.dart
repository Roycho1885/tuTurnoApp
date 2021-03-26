import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  String _nombre;
  String _apellido;
  String _dni;
  String _direccion;
  String _email;
  String _contrasena;
  String _codigo;
  String _gym;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _ocultar = true;

  void _toogleboton() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

  Widget _crearCampoNombre() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Nombre';
        }
        return null;
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _crearCampoApellido() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Apellido', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Apellido';
        }
        return null;
      },
      onSaved: (String value) {
        _apellido = value;
      },
    );
  }

  Widget _crearCampoDni() {
    return TextFormField(
      maxLength: 8,
      keyboardType: TextInputType.number,
      decoration:
          InputDecoration(labelText: 'DNI', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese DNI';
        }
        return null;
      },
      onSaved: (String value) {
        _dni = value;
      },
    );
  }

  Widget _crearCampoDireccion() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Dirección', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Dirección';
        }
        return null;
      },
      onSaved: (String value) {
        _direccion = value;
      },
    );
  }

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

  Widget _crearCampoContrasena() {
    return TextFormField(
      obscureText: _ocultar,
      decoration: InputDecoration(
        helperText: "La contraseña debe contener al menos 6 caracteres",
        labelText: 'Contraseña',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: _toogleboton,
          icon: Icon(Icons.visibility_off),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Contraseña';
        }
        return null;
      },
      onSaved: (String value) {
        _contrasena = value;
      },
    );
  }

  Widget _crearCampoCodigo() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration:
          InputDecoration(labelText: 'Código', prefixIcon: Icon(Icons.lock)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Código';
        }
        return null;
      },
      onSaved: (String value) {
        _direccion = value;
      },
    );
  }

  Widget _crearCampoGym() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
      ),
      body: Center(
        child: (_width > 640) ? _pantallaGrande() : _pantallaChica(),
      ),
    );
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
                _crearCampoNombre(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoApellido(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoDni(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoDireccion(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoEmail(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoContrasena(),
                SizedBox(
                  height: 20,
                ),
                /*_crearCampoGym(),*/
                _crearCampoCodigo(),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Registrar'),
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
                _crearCampoNombre(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoApellido(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoDni(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoDireccion(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoEmail(),
                SizedBox(
                  height: 20,
                ),
                _crearCampoContrasena(),
                SizedBox(
                  height: 20,
                ),
                /*_crearCampoGym(),*/
                _crearCampoCodigo(),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Registrar'),
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
}
