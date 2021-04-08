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
  bool lista = false;
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
  String rubrosselec, gimselec;

  @override
  void initState() {
    super.initState();
  }

  void _toogleboton() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

  void _cambiodeopciones1(String opcion) {
    setState(() {});
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
      stream: FirebaseFirestore.instance.collection('clientesList').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<DocumentSnapshot> docs = snapshot.data.docs;
        return Container(
          height: 200,
          width: 100,
          child: ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = docs[index].data();
              return ListTile(
                title: Text(data['nombre']),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Ah seleccionado ' + data['nombre'])));
                  rubrosselec = data['nombre'];
                  print(rubrosselec);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _crearCampoGym() {
    if (rubrosselec == null) {
      return Center(
        child: Text('Seleccione un Rubro'),
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('clientesList')
              .doc(rubrosselec)
              .collection(rubrosselec)
              .orderBy('nombre')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> docs = snapshot.data.docs;
            return Container(
              height: 200,
              width: 100,
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = docs[index].data();
                  return ListTile(
                    title: Text(data['nombre']),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Ah seleccionado ' + data['nombre'])));
                      gimselec = data['nombre'];
                      print(gimselec);
                    },
                  );
                },
              ),
            );
          });
    }
  }

  //CHECKBOX POLITICAS
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
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Seleccione Rubro'),
                        content: _crearCampoRubro(),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Text('Aceptar'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Cancelar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Seleccione un rubro'),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Seleccione una opcion'),
                        content: _crearCampoGym(),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Text('Aceptar'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Cancelar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Seleccione un opcion'),
                ),
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
                SizedBox(
                  height: 30,
                ),
                //_crearCampoGym(),
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

//METODO REGISTRAR CLIENTE
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

//ENVIO DE VALIDACION CLIENTE
Future<void> validarcliente() async {
  User clienteEmail = FirebaseAuth.instance.currentUser;
  if (!clienteEmail.emailVerified) {
    await clienteEmail.sendEmailVerification();
  }
}

//COMPRUEBO EL CODIGO DE ACCESO
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
