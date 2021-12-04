import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';
import 'package:path/path.dart' as Path;

class PerfilAdministrador extends StatefulWidget {
  final String? nombreGym;
  final String? nombreCli;
  final String? idDoc;
  const PerfilAdministrador(
      {Key? key,
      required this.nombreGym,
      required this.nombreCli,
      required this.idDoc})
      : super(key: key);
  @override
  _PerfilAdministrador createState() => _PerfilAdministrador();
}

class _PerfilAdministrador extends State<PerfilAdministrador> {
  XFile? _imagen;
  String? _urlFotoWeb, _urlFotoAndroid;
  File? _foto;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _controlNombre = TextEditingController();
  TextEditingController _controlApellido = TextEditingController();
  TextEditingController _controlDni = TextEditingController();
  TextEditingController _controlDire = TextEditingController();
  TextEditingController _controlTele = TextEditingController();
  final color = Colors.indigo;
  var mascara = new MaskTextInputFormatter(
      mask: '+54 ###### - ####', filter: {'#': RegExp(r'[0-9]')});
  late String _nombre;
  late String _apellido;
  late String _dni;
  late String _direccion;
  late String _telefono;

  @override
  Widget build(BuildContext context) {
    Future getImagen() async {
      XFile? imagen =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _imagen = imagen;
      });
    }

    Future subirImgPerfil() async {
      bool bandera = false;
      if (kIsWeb) {
        bandera = true;
        firebase_storage.Reference storage =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'imagenesClientes/${widget.nombreCli}/${Path.basename(_imagen!.path)}');
        await storage
            .putData(await _imagen!.readAsBytes(),
                firebase_storage.SettableMetadata(contentType: 'image/jpg'))
            .whenComplete(
                () async => await storage.getDownloadURL().then((value) => {
                      setState(() {
                        _urlFotoWeb = value;
                      })
                    }));
      } else {
        firebase_storage.Reference storage =
            firebase_storage.FirebaseStorage.instance.ref().child(
                'imagenesClientes/${widget.nombreCli}/${Path.basename(_imagen!.path)}');
        _foto = File(_imagen!.path);
        firebase_storage.UploadTask upload = storage.putFile(_foto!);
        await upload.whenComplete(
            () async => await storage.getDownloadURL().then((value) => {
                  setState(() {
                    _urlFotoAndroid = value;
                  })
                }));
      }
      return bandera ? _urlFotoWeb : _urlFotoAndroid;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBarGen(widget.nombreCli, widget.nombreGym),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: getUsuarios(widget.nombreGym!, widget.idDoc!),
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
                final datosCliente = Cliente.fromSnapshot(data);
                _controlNombre.text = data['nombre'];
                _controlApellido.text = data['apellido'];
                _controlDni.text = data['dni'];
                _controlDire.text = data['direccion'];
                _controlTele.text = data['telefono'];
                return Column(
                  children: <Widget>[
                    consTop(data['imgperfil'], getImagen),
                    consContenido(data['nombre'], data['email']),
                    SizedBox(height: 10),
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
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
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
                                        subirImgPerfil().then((value) => {
                                              actualizar(
                                                  datosCliente,
                                                  _controlNombre.text,
                                                  _controlApellido.text,
                                                  _controlDni.text,
                                                  _controlDire.text,
                                                  _controlTele.text,
                                                  value),
                                            });
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
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            },
          ),
        ],
      ),
    );
  }

//OBTENGO UN SNAPSHOT DEL DOCUMENTO ADMIN LOGEADO CON LOS DATOS
  getUsuarios(String nombreGym, String iddocument) {
    return FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(nombreGym)
        .collection('Clientes')
        .doc(iddocument)
        .snapshots();
  }

  Widget consContenido(String nombre, String email) {
    return Column(
      children: [
        SizedBox(height: 8),
        Text(
          nombre,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2),
        Text(
          email,
          style: TextStyle(fontSize: 16, color: Colors.black38),
        ),
      ],
    );
  }

  Widget consTop(String imgperfil, Future getImagen()) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(padding: EdgeInsets.all(30)),
        Positioned(
            child: (kIsWeb)
                ? imagenPerfilWeb(imgperfil, getImagen)
                : imagenPerfilAndroid(imgperfil, getImagen)),
      ],
    );
  }

  Widget imagenPerfilWeb(String imagen, Future getImagen()) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade800,
          child: ClipOval(
            child: SizedBox(
                width: 120,
                height: 120,
                child: (_imagen != null)
                    ? Image.network(_imagen!.path, fit: BoxFit.fill)
                    : Image.network(imagen, fit: BoxFit.fill, scale: 1)),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: crearIconoFoto(getImagen),
        ),
      ],
    );
  }

  Widget imagenPerfilAndroid(String imagen, Future getImagen()) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.black,
          child: ClipOval(
            child: SizedBox(
                width: 120,
                height: 120,
                child: (_imagen != null)
                    ? Image.file(File(_imagen!.path), fit: BoxFit.fill)
                    : Image.network(imagen, fit: BoxFit.fill, scale: 1)),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: crearIconoFoto(getImagen),
        ),
      ],
    );
  }

  Widget crearIconoFoto(Future getImagen()) {
    return crearIconoFotoSeg(
      color: Colors.white,
      all: 3,
      child: InkWell(
        onTap: () {
          getImagen();
        },
        child: crearIconoFotoSeg(
          color: Colors.indigo,
          all: 10,
          child: Icon(Icons.edit, size: 15, color: Colors.white),
        ),
      ),
    );
  }

  Widget crearIconoFotoSeg(
          {required Widget child, required double all, required Color color}) =>
      ClipOval(
        child:
            Container(padding: EdgeInsets.all(all), child: child, color: color),
      );

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
      String dire, String tele, String? imgUrl) {
    FirebaseFirestore.instance.runTransaction((Transaction trans) async {
      trans.update(cliente.referencia!, {
        'nombre': nombre,
        'apellido': apellido,
        'dni': dni,
        'direccion': dire,
        'telefono': tele,
        'imgperfil': imgUrl,
      });
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Datos Modificados con éxito'),
        )));
  }
}
