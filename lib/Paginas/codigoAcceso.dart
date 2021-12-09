import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';

class CodigoAccesoAdmin extends StatefulWidget {
  final Gimnasios? pasoDatosGim;
  final String? nombreCli;
  //CONSTANTE PARA PASO DE ARGUMENTOS
  const CodigoAccesoAdmin(
      {Key? key, required this.pasoDatosGim, required this.nombreCli})
      : super(key: key);
  @override
  _CodigoAccesoAdmin createState() => _CodigoAccesoAdmin();
}

class _CodigoAccesoAdmin extends State<CodigoAccesoAdmin> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  //STREAM PARA USAR EN STREAMBUILDER QUE HACE REFERENCIA A LA BD
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('clientesList')
      .doc('Gimnasios')
      .collection('Gimnasios')
      .snapshots();
  late String _codigo = '';

  @override
  Widget build(BuildContext context) {
    return _pantalla();
  }

  Widget _pantalla() {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre)),
      body: Center(
        child: _codigoingreso(),
      ),
    );
  }

  Widget _codigoingreso() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 60, bottom: 100),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        elevation: 10,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Ingrese nuevo código',
                        style:
                            TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _controller,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 5),
                    //STREAMBUILDER PARA REFRESCAR EL CODIGO DE ACCESO CUANDO LO CAMBIA
                    StreamBuilder<QuerySnapshot>(
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          String codigo = '';
                          if (snapshot.hasError) {
                            return Text('Algo anda mal...Reintenta');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: Colors.amber,
                            );
                          }
                          snapshot.data!.docs.forEach((doc) {
                            if (widget.pasoDatosGim!.nombre == doc['nombre']) {
                              codigo = doc['codigoacceso'];
                            }
                          });
                          return Text(codigo,
                              style: TextStyle(fontWeight: FontWeight.bold));
                        },
                        stream: _stream),
                    Text(
                      _codigo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (!_formkey.currentState!.validate()) {
                              return;
                            }
                            _formkey.currentState!.save();
                            _controller.clear();
                            registrarCodigo();
                          },
                          child: Text('Guardar Cambios'),
                        ),
                      ],
                    ),
                    /* Container(
                      height: 50,
                      width: 260,
                      child: ElevatedButton(
                        child: Text('Aceptar'),
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          
                        },
                      ),
                    ), */
                  ],
                ),
              ),
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
