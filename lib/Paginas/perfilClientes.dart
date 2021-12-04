import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';

class PerfilClientes extends StatefulWidget {
  final Gimnasios? pasoDatosGim;
  final String? nombreCli;
  final Cliente? cliente;
  const PerfilClientes(
      {Key? key,
      required this.cliente,
      required this.nombreCli,
      required this.pasoDatosGim})
      : super(key: key);
  @override
  _PerfilClientes createState() => _PerfilClientes();
}

class _PerfilClientes extends State<PerfilClientes> {
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

  final double perfilHeight = 100;

  @override
  Widget build(BuildContext context) {
    _controlNombre.text = widget.cliente!.nombre;
    _controlApellido.text = widget.cliente!.apellido;
    _controlDni.text = widget.cliente!.dni;
    _controlDire.text = widget.cliente!.direccion;
    _controlTele.text = widget.cliente!.telefono;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          consTop(),
          consContenido(),
          SizedBox(
            height: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 10,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        _crearCampoNombre(),
                        _crearCampoApellido(),
                        _crearCampoDni(),
                        _crearCampoDireccion(),
                        _crearCampoTelefono()
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            if (!_formkey.currentState!.validate()) {
                              return;
                            } else {
                              actualizar(
                                  widget.cliente!,
                                  _controlNombre.text,
                                  _controlApellido.text,
                                  _controlDni.text,
                                  _controlDire.text,
                                  _controlTele.text);
                            }
                          },
                          child: Text("Guardar Cambios"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget consContenido() {
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
      radius: 60,
      backgroundColor: Colors.black,
      child: ClipOval(
        child: SizedBox(
            width: 120,
            height: 120,
            child: Image.network(widget.cliente!.imgPerfil, fit: BoxFit.fill)),
      ),
    );
  }

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
      controller: _controlTele,
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

  actualizar(Cliente cliente, String nombre, String apellido, String dni,
      String dire, String tele) {
    FirebaseFirestore.instance.runTransaction((Transaction trans) async {
      trans.update(cliente.referencia!, {
        'nombre': nombre,
        'apellido': apellido,
        'dni': dni,
        'direccion': dire,
        'telefono': tele
      });
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Cliente modificado con éxito'))));
  }
}
