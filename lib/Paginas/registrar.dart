import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  var mascara = new MaskTextInputFormatter(
      mask: '+54 ###### - ####', filter: {'#': RegExp(r'[0-9]')});
  bool poli = false;
  bool cod = false;
  late String _nombre;
  late String _apellido;
  late String _dni;
  late String _direccion;
  late String _telefono;
  late String _email;
  late String _contrasena;
  late String _codigo;
  late String _nombregym;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _ocultar = true;

  /* //DROPDOWN
  Rubros? rselec;
  Gimnasios? gselec;
  List<Rubros> rubrosfeos = [];
  List<Gimnasios> gimfeos = [];
  //-------------------------------- */

  @override
  void initState() {
    super.initState();
    //OBTENGO LOS RUBROS PRIMERO PARA EL DROPDOWN RUBRO
    /* obtenerrubros().then((List<Rubros> valor) {
      setState(() {});
      rubrosfeos = valor;
    }); */
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Nombre';
        }
        return null;
      },
      onSaved: (value) {
        _nombre = value!.trim();
      },
    );
  }

  Widget _crearCampoApellido() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Apellido', prefixIcon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Apellido';
        }
        return null;
      },
      onSaved: (value) {
        _apellido = value!.trim();
      },
    );
  }

  Widget _crearCampoDni() {
    return TextFormField(
      maxLength: 8,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration:
          InputDecoration(labelText: 'DNI', prefixIcon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese DNI';
        } else {
          if (value.length != 8) {
            return "Ingrese DNI completo";
          }
        }
        return null;
      },
      onSaved: (value) {
        _dni = value!.trim();
      },
    );
  }

  Widget _crearCampoDireccion() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Dirección', prefixIcon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Dirección';
        }
        return null;
      },
      onSaved: (value) {
        _direccion = value!.trim();
      },
    );
  }

  Widget _crearCampoTelefono() {
    return TextFormField(
      inputFormatters: [mascara],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: 'Teléfono', prefixIcon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Teléfono';
        } else {
          if (value.length != 17) {
            return "Ingrese el número completo";
          }
        }
        return null;
      },
      onSaved: (value) {
        _telefono = value!.trim();
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Email';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Por favor ingrese un email válido';
        }

        return null;
      },
      onSaved: (value) {
        _email = value!.trim();
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Contraseña';
        }
        return null;
      },
      onSaved: (value) {
        _contrasena = value!.trim();
      },
    );
  }

  Widget _crearCampoCodigo() {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 6,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration:
          InputDecoration(labelText: 'Código', prefixIcon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Ingrese Código';
        }
        return null;
      },
      onSaved: (value) {
        _codigo = value!.trim();
      },
    );
  }

  //----------------------------------------------------------------------

  //CHECKBOX POLITICAS
  Widget crearCheck() => CheckboxListTile(
      activeColor: Colors.amber.shade700,
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
          this.poli = value!;
        });
      });
  //-------------------------------------------------------------------

//ACA SE MUESTRAN LOS WIDGETS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
      ),
      body: Center(
        child: _pantallaGrande()
      ),
    );
  }
  //----------------------------------------------

  /* Widget _multiplesdropdown() {
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
              border: Border.all(color: Colors.amber.shade700, width: 2),
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
              border: Border.all(color: Colors.amber.shade700, width: 2),
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
  } */

/* //LOS ONCHANGE PARA LOS DROPDOWNS Y LAS FUNCIONES PARA LISTARLOS DESDE LA DB
  void onRubroCambio(rub) {
    setState(() {
      rselec = rub;
      gimfeos = [];
      gselec;
    });
    obtenergim(rselec!.nombre).then((List<Gimnasios> valor) {
      setState(() {});
      gimfeos = valor;
    });
  }

  void onGimCambio(gim) {
    setState(() {
      gselec = gim;
    });
  } */

  /* Future<List<Rubros>> obtenerrubros() async {
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
  } */

  /* Future<List<Gimnasios>> obtenergim(String elrubroselec) async {
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
  } */
  //-----------------------------------------------------------------

  Widget _pantallaGrande() {
    final gimdatos = ModalRoute.of(context)!.settings.arguments as Gimnasios;
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.all(20),
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
                  _crearCampoTelefono(),
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
                  //_multiplesdropdown(),
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
                        if (!_formkey.currentState!.validate()) {
                          return;
                        } else {
                          if (!poli) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Debe aceptar las Políticas de Privacidad')));
                            return;
                          }
                        }

                        _formkey.currentState!.save();
                        if (_codigo == gimdatos.codigoacceso) {
                          registrar(
                              _nombre,
                              _apellido,
                              _dni,
                              _direccion,
                              _telefono,
                              _email,
                              _contrasena,
                              _nombregym = gimdatos.nombre,
                              _codigo,
                              context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('El código ingresado no coincide')));
                        }
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
  Future<void> registrar(nombre, apellido, dni, direccion, telefono, email,
      contrasena, nombregym, codigo, context) async {
    final clienteNuevo = Cliente(nombre: nombre, apellido: apellido, dni: dni, direccion: direccion, 
    telefono: telefono, email: email, nombregym: nombregym, 
    admin: "No", token: "0", ultimopago: "Nunca", 
    fechavencimiento: "Nunca", estadopago: 0, imgPerfil: "Vacio");

    CollectionReference clinuevo =
        FirebaseFirestore.instance.collection('clientesList');

    try {
      UserCredential userCreden = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: contrasena);

      validarcliente(context);
      Navigator.of(context).pushNamed('/');
      return FirebaseFirestore.instance.runTransaction((transaction) =>
           clinuevo
          .doc('Gimnasios')
          .collection('Gimnasios')
          .doc(nombregym)
          .collection("Clientes").doc()
          .set(clienteNuevo.toJson())
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cliente registrado con éxito')))));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('La contraseña debe contener al menos 6 caracteres')));
      } else {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Email utilizado en una cuenta existente')));
        }
      }
    } catch (e) {}
  }

//ENVIO DE VALIDACION CLIENTE
  Future<void> validarcliente(context) async {
    User? clienteEmail = FirebaseAuth.instance.currentUser;
    if (!clienteEmail!.emailVerified) {
      await clienteEmail.sendEmailVerification();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email enviado con éxito')));
    }
  }
