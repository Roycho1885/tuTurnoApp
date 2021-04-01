import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:url_launcher/url_launcher.dart';

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  bool poli = false;
  String _nombre;
  String _apellido;
  String _dni;
  String _direccion;
  String _email;
  String _contrasena;
  String _codigo;
  String _gym;
  String _rubro;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _ocultar = true;

  @override
  void initState() {
    super.initState();
  }

  void _toogleboton() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

  Widget _crearCampoNombre() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration:
          InputDecoration(labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Nombre';
        }
        return null;
      },
      onSaved: (String value) {
        _nombre = value.trim();
      },
    );
  }

  Widget _crearCampoApellido() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Apellido', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Apellido';
        }
        return null;
      },
      onSaved: (String value) {
        _apellido = value.trim();
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
        _dni = value.trim();
      },
    );
  }

  Widget _crearCampoDireccion() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Dirección', prefixIcon: Icon(Icons.person)),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Ingrese Dirección';
        }
        return null;
      },
      onSaved: (String value) {
        _direccion = value.trim();
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
        _email = value.trim();
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
        _contrasena = value.trim();
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
        _codigo = value.trim();
      },
    );
  }

  Widget _crearCampoRubro() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('clientesList').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DropdownMenuItem> rub = [];
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot docs = snapshot.data.docs[i];
            rub.add(
              DropdownMenuItem(
                child: Text(docs.id),
                value: '${docs.id}',
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                  items: rub,
                  onChanged: (valor) {
                    setState(() {
                      this._rubro = valor;
                    });
                  },
                  isExpanded: false,
                  value: _rubro,
                  hint: new Text('Seleccione Rubro')),
            ],
          );
        });
  }

  Widget _crearCampoGym() {
    if (_rubro == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton(
              items: null,
              isExpanded: false,
              hint: new Text('Seleccione primero un Rubro')),
        ],
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('clientesList')
              .doc(_rubro)
              .collection(_rubro)
              .orderBy('nombre')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DropdownMenuItem> gim = [];
            for (int i = 0; i < snapshot.data.docs.length; i++) {
              DocumentSnapshot docs = snapshot.data.docs[i];
              gim.add(
                DropdownMenuItem(
                  child: Text(
                    docs['nombre'],
                  ),
                  value: '${docs.get('nombre')}',
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                    items: gim,
                    onChanged: (valor) {
                      setState(() {
                        this._gym = valor;
                      });
                    },
                    isExpanded: false,
                    value: _gym,
                    hint: new Text('Seleccione ' + _rubro)),
              ],
            );
          });
    }
  }

  //ESTE ES EL CHECKBOX POLITICAS
  Widget crearCheck() => CheckboxListTile(
      title: GestureDetector(
        child: Text(
          'Acepto las Políticas de Privacidad',
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.blue),
        ),
        onTap: () =>
            launch('https://tuturno.web.app/Pol%C3%ADticas-de-Privacidad.html'),
      ),
      value: poli,
      onChanged: (value) {
        setState(() {
          this.poli = value;
        });
      });

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
                  height: 40,
                ),
                _crearCampoApellido(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoDni(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoDireccion(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoEmail(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoContrasena(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoRubro(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoGym(),
                SizedBox(
                  height: 40,
                ),
                _crearCampoCodigo(),
                SizedBox(
                  height: 40,
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
                      } else {
                        if (_gym == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Seleccione un gimnasio')));
                          return;
                        } else {
                          if (!poli) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Debe aceptar las Políticas de Privacidad')));
                            return;
                          }
                        }
                      }
                      _formkey.currentState.save();
                      registrar(_nombre, _apellido, _dni, _direccion, _email,
                          _contrasena, _gym, _codigo, context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                crearCheck(),
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
                  height: 30,
                ),
                _crearCampoApellido(),
                SizedBox(
                  height: 30,
                ),
                _crearCampoDni(),
                SizedBox(
                  height: 30,
                ),
                _crearCampoDireccion(),
                SizedBox(
                  height: 30,
                ),
                _crearCampoEmail(),
                SizedBox(
                  height: 30,
                ),
                _crearCampoContrasena(),
                SizedBox(
                  height: 30,
                ),
                _crearCampoRubro(),
                SizedBox(height: 30),
                _crearCampoGym(),
                SizedBox(
                  height: 30,
                ),
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
                      } else {
                        if (_gym == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Seleccione un gimnasio')));
                          return;
                        } else {
                          if (!poli) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Debe aceptar las Políticas de Privacidad')));
                            return;
                          }
                        }
                      }
                      _formkey.currentState.save();
                      comprobarcodigo(_gym, _codigo);
                      /*registrar(_nombre, _apellido, _dni, _direccion, _email,
                          _contrasena, _gym, _codigo, context);*/
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                crearCheck(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> registrar(nombre, apellido, dni, direccion, email, contrasena, gym,
    codigo, context) async {
  final clienteNuevo = Cliente(nombre, apellido, dni, direccion, email, gym,
      'No', 'Nada', 'Nada', 'Nada', 0);

  CollectionReference clinuevo =
      FirebaseFirestore.instance.collection('clientesPrincipal');

  try {
    UserCredential userCreden = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: contrasena);

    validarcliente();
    return clinuevo
        .doc('cli_gym')
        .collection(gym)
        .add(clienteNuevo.toJson())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cliente registrado con éxito'))));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('La contraseña debe contener al menos 6 caracteres')));
    } else {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email utilizado en una cuenta existente')));
      }
    }
  } catch (e) {
    print(e);
  }
}

Future<void> validarcliente() async {
  User clienteEmail = FirebaseAuth.instance.currentUser;
  if (!clienteEmail.emailVerified) {
    await clienteEmail.sendEmailVerification();
  }
}

void comprobarcodigo(String nombrelocal, String codigolocal) {
  bool verdadero = false;
  FirebaseFirestore.instance
      .collection('clientesList')
      .doc('rubros')
      .collection('gimnasios')
      .get()
      .then((QuerySnapshot query) {
    query.docs.forEach((doc) {
      if (nombrelocal == doc['nombre'] && codigolocal == doc['codigoacceso']) {
        verdadero = true;
      }
      print(verdadero);
      return verdadero;
    });
  });
}
