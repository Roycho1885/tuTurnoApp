import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';

class CodigoAccesoAdmin extends StatefulWidget {
  final Gimnasios? pasoDatosGim;
  final String? nombreCli;
  const CodigoAccesoAdmin(
      {Key? key, required this.pasoDatosGim, required this.nombreCli})
      : super(key: key);
  @override
  _CodigoAccesoAdmin createState() => _CodigoAccesoAdmin();
}

class _CodigoAccesoAdmin extends State<CodigoAccesoAdmin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _codigo;

  @override
  void initState() {
    super.initState();
    _codigo = widget.pasoDatosGim!.codigoacceso;
  }

  @override
  Widget build(BuildContext context) {
    return _pantalla();
  }

  Widget _pantalla() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre)),
      body: Center(
        child: _codigoingreso(),
      ),
    );
  }

  Widget _codigoingreso() {
    return Container(
      padding: EdgeInsets.only(top: 100, left: 20, right: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Ingrese nuevo código',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese Código';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _codigo = value!.trim();
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Código',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Código Actual',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  _codigo,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Container(
                  height: 50,
                  width: 260,
                  child: ElevatedButton(
                    child: Text('Aceptar'),
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      registrarCodigo();
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

  Future<void> registrarCodigo() async {
    CollectionReference codigo =
        FirebaseFirestore.instance.collection('clientesList');
    return codigo
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(widget.pasoDatosGim!.nombre)
        .update({'codigoacceso': _codigo}).then((value) =>
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Código registrado con éxito'))));
  }
}
