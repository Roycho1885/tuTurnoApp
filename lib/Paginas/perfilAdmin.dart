import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';

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
                _controlNombre.text = data['nombre'];
                _controlApellido.text = data['apellido'];
                _controlDni.text = data['dni'];
                _controlDire.text = data['direccion'];
                _controlTele.text = data['telefono'];
                return Form(
                  child: Column(
                    children: <Widget>[
                      consTop(data['imgperfil']),
                      consContenido(data['nombre'], data['email']),
                      SizedBox(height: 10),
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

  Widget consTop(String imgperfil) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(padding: EdgeInsets.all(30)),
        Positioned(child: imagenPerfil(imgperfil)),
      ],
    );
  }

  Widget imagenPerfil(String imagen) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: NetworkImage(imagen, scale: 1),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: crearIconoFoto(),
        ),
      ],
    );
  }

  Widget crearIconoFoto() {
    return crearIconoFotoSeg(
      color: Colors.white,
      all: 3,
      child: crearIconoFotoSeg(
        color: Colors.indigo,
        all: 8,
        child: InkWell(
          onTap: () {},
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
}
