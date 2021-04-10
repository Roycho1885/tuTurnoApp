import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Modelo/rubros.dart';
import 'package:url_launcher/url_launcher.dart';

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  bool poli = false;
  bool cod = false;
  String _nombre;
  String _apellido;
  String _dni;
  String _direccion;
  String _email;
  String _contrasena;
  String _codigo;
  String _rubronombre;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _ocultar = true;

  //DROPDOWN
  Rubros rselec;
  Gimnasios gselec;
  List<Rubros> rubrosfeos = [];
  List<Gimnasios> gimfeos = [];
  //--------------------------------

  @override
  void initState() {
    super.initState();
    //OBTENGO LOS RUBROS PRIMERO PARA EL DROPDOWN RUBRO
    obtenerrubros().then((List<Rubros> valor) {
      setState(() {});
      rubrosfeos = valor;
    });
  }

  void _toogleboton() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

//CREACION DE LOS WIDGETS
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

  //----------------------------------------------------------------------

  //CHECKBOX POLITICAS
  Widget crearCheck() => CheckboxListTile(
      activeColor: Colors.amber,
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
  //-------------------------------------------------------------------

//ACA SE MUESTRAN LOS WIDGETS
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
  //----------------------------------------------

  Widget _multiplesdropdown() {
    return Container(
      width: 600,
      height: 200,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Rubros>(
                dropdownColor: Colors.amber[200],
                hint: Text('Seleccione Rubro'),
                value: rselec,
                isExpanded: true,
                items: rubrosfeos.map((Rubros rub) {
                  return DropdownMenuItem<Rubros>(
                    value: rub,
                    child: Text(rub.nombre),
                  );
                }).toList(),
                onChanged: onRubroCambio,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Colors.amber, width: 2),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Gimnasios>(
                hint: Text('Seleccione primero un Rubro'),
                value: gselec,
                isExpanded: true,
                dropdownColor: Colors.amber[200],
                items: gimfeos.map((Gimnasios gim) {
                  return DropdownMenuItem<Gimnasios>(
                    value: gim,
                    child: Text(gim.nombre),
                  );
                }).toList(),
                onChanged: onGimCambio,
              ),
            ),
          ),
        ],
      ),
    );
  }

//LOS ONCHANGE PARA LOS DROPDOWNS Y LAS FUNCIONES PARA LISTARLOS DESDE LA DB
  void onRubroCambio(rub) {
    setState(() {
      rselec = rub;
      gimfeos = [];
      gselec = null;
    });
    obtenergim(rselec.nombre).then((List<Gimnasios> valor) {
      setState(() {});
      gimfeos = valor;
    });
  }

  void onGimCambio(gim) {
    setState(() {
      gselec = gim;
    });
  }

  Future<List<Rubros>> obtenerrubros() async {
    List rubrosmalditos = [];
    await FirebaseFirestore.instance
        .collection('clientesList')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        rubrosmalditos.add(doc.data());
      });
    });
    return rubrosmalditos.map((e) => Rubros.fromMap(e)).toList();
  }

  Future<List<Gimnasios>> obtenergim(String elrubroselec) async {
    List gimmalditos = [];
    await FirebaseFirestore.instance
        .collection('clientesList')
        .doc(elrubroselec)
        .collection(elrubroselec)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        gimmalditos.add(doc.data());
      });
    });
    return gimmalditos.map((e) => Gimnasios.fromMap(e)).toList();
  }
  //-----------------------------------------------------------------

  Widget _pantallaGrande() {
    return Scrollbar(
      child: Container(
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
                  _multiplesdropdown(),
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
                          if (rselec == null || gselec == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Seleccione opciones')));
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
                        comprobarcodigo(rselec.nombre, _codigo, gselec.nombre)
                            .then((value) {
                          if (value) {
                            registrar(
                                _nombre,
                                _apellido,
                                _dni,
                                _direccion,
                                _email,
                                _contrasena,
                                _rubronombre = gselec.nombre,
                                _codigo,
                                context,
                                rselec.nombre);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('El código ingresado no coincide')));
                          }
                        });
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
      ),
    );
  }

  Widget _pantallaChica() {
    return Scrollbar(
      child: Container(
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
                  _multiplesdropdown(),
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
                          if (rselec == null || gselec == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Seleccione opciones')));
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
                        //comprobarcodigo(gselec.nombre, _codigo);
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
      ),
    );
  }
}

//METODO REGISTRAR CLIENTE
Future<void> registrar(nombre, apellido, dni, direccion, email, contrasena,
    rubronombre, codigo, context, rubselec) async {
  final clienteNuevo = Cliente(nombre, apellido, dni, direccion, email,
      rubronombre, 'No', 'Nada', 'Nada', 'Nada', 0);

  CollectionReference clinuevo =
      FirebaseFirestore.instance.collection('clientesPrincipal');

  try {
    UserCredential userCreden = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: contrasena);

    validarcliente();
    return clinuevo
        .doc(rubselec)
        .collection(rubronombre)
        .doc('Clientes')
        .collection('Clientes')
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
  } catch (e) {}
}

//ENVIO DE VALIDACION CLIENTE
Future<void> validarcliente() async {
  User clienteEmail = FirebaseAuth.instance.currentUser;
  if (!clienteEmail.emailVerified) {
    await clienteEmail.sendEmailVerification();
  }
}

//COMPRUEBO EL CODIGO DE ACCESO
Future<bool> comprobarcodigo(
    String nombrerubro, String codigolocal, String nombrelocal) async {
  bool verdadero = false;
  await FirebaseFirestore.instance
      .collection('clientesList')
      .doc(nombrerubro)
      .collection(nombrerubro)
      .get()
      .then((QuerySnapshot query) {
    query.docs.forEach((doc) {
      if (nombrelocal == doc['nombre'] && codigolocal == doc['codigoacceso']) {
        verdadero = true;
      }
    });
  });
  return verdadero;
}
