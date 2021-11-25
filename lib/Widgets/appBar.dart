import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
TextEditingController _controlNombre = TextEditingController();
TextEditingController _controlApellido = TextEditingController();
TextEditingController _controlDni = TextEditingController();
TextEditingController _controlDire = TextEditingController();
TextEditingController _controlTele = TextEditingController();
var mascara = new MaskTextInputFormatter(
    mask: '+54 ###### - ####', filter: {'#': RegExp(r'[0-9]')});
late String _nombre;
late String _apellido;
late String _dni;
late String _direccion;
late String _telefono;

// ignore: must_be_immutable
class AppBarGen extends AppBar {
  AppBarGen(String? nombreDelCli, String? nombreDelGym, {Key? key})
      : super(
          key: key,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombreDelGym!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Hola ' + nombreDelCli!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: PopupMenuButton(
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed: () {
                                _abrirPopUpPerfilAdmin(context, nombreDelGym);
                              },
                              label: Text('Mi Perfil'),
                              icon: Icon(Icons.person)),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/');
                            },
                            icon: Icon(Icons.logout),
                            label: Text('Cerrar Sesión'),
                          ),
                        ),
                      ]),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Color(0x041E47), Colors.black54],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        );
}

//OBTENGO EL ID DEL DOCUMENTO ADMIN QUE ESTA LOGEADO
Future<String> obtenerclientes(User user, String nombregym) async {
  String idCliente = "";
  await FirebaseFirestore.instance
      .collection('clientesList')
      .doc('Gimnasios')
      .collection('Gimnasios')
      .doc(nombregym)
      .collection('Clientes')
      .get()
      .then((QuerySnapshot query) {
    query.docs.forEach((doc) {
      if (user.email == doc['email'] && doc['nombregym'] == nombregym) {
        idCliente = doc.id;
      }
    });
  });
  return idCliente;
}

//OBTENGO UN SNAPSHOT DEL DOCUMENTO ADMIN LOGEADO CON LOS DATOS
getUsuarios(String nombreGym, String idCli) {
  return FirebaseFirestore.instance
      .collection('clientesList')
      .doc('Gimnasios')
      .collection('Gimnasios')
      .doc(nombreGym)
      .collection('Clientes')
      .doc(idCli)
      .snapshots();
}

_abrirPopUpPerfilAdmin(context, String nombreGim) {
  final User? user = FirebaseAuth.instance.currentUser;
  obtenerclientes(user!, nombreGim).then((value) {
    Alert(
        context: context,
        title: "Mi Perfil",
        content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: getUsuarios(nombreGim, value),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Algo anda mal...Reintenta');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
            if (snapshot.hasData) {
              var data = snapshot.data!;
              _controlNombre.text = data['nombre'];
              _controlApellido.text = data['apellido'];
              _controlDni.text = data['dni'];
              _controlDire.text = data['direccion'];
              _controlTele.text = data['telefono'];
              return Form(
                child: Column(
                  children: <Widget>[
                    _crearCampoNombre(),
                    _crearCampoApellido(),
                    _crearCampoDni(),
                    _crearCampoDireccion(),
                    _crearCampoTelefono()
                  ],
                ),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          },
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Guardar Cambios",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  });
}

/* Widget consContenido() {
    return Column(
      children: [
        SizedBox(height: 8),
        Text(
          widget.cliente!.nombre,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          widget.cliente!.email,
          style: TextStyle(fontSize: 16, color: Colors.black38),
        ),
      ],
    );
  }

  Widget consTop() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(padding: EdgeInsets.all(30)),
        Positioned(child: imagenPerfil()),
      ],
    );
  }

  Widget imagenPerfil() {
    return CircleAvatar(
      radius: perfilHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/tuturno-91997.appspot.com/o/LogoClientes%2F1625503819045.png?alt=media&token=7972e01d-f547-4cd0-864a-97702362d353'),
    );
  } */

//widgets TextField
Widget _crearCampoNombre() {
  return TextFormField(
    controller: _controlNombre,
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
    controller: _controlApellido,
    keyboardType: TextInputType.text,
    decoration:
        InputDecoration(labelText: 'Apellido', prefixIcon: Icon(Icons.person)),
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
    controller: _controlDni,
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
    controller: _controlDire,
    keyboardType: TextInputType.text,
    decoration:
        InputDecoration(labelText: 'Dirección', prefixIcon: Icon(Icons.person)),
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
    controller: _controlTele,
    inputFormatters: [mascara],
    keyboardType: TextInputType.phone,
    decoration:
        InputDecoration(labelText: 'Teléfono', prefixIcon: Icon(Icons.person)),
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
