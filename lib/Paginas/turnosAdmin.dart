import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Modelo/Turno.dart';
import 'package:tuturnoapp/Modelo/datosDiasCheck.dart';
import 'package:tuturnoapp/Modelo/notifier.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';
import 'package:provider/provider.dart';

class TurnosAdmin extends StatefulWidget {
  final Gimnasios? pasoDatosGim;
  final String? nombreCli;
  //CONSTANTE PARA PASO DE ARGUMENTOS
  const TurnosAdmin(
      {Key? key, required this.pasoDatosGim, required this.nombreCli})
      : super(key: key);
  @override
  _TurnosAdminState createState() => _TurnosAdminState();
}

class _TurnosAdminState extends State<TurnosAdmin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _controlDias = TextEditingController();
  TextEditingController _controlHora = TextEditingController();
  TextEditingController _controlDisciplina = TextEditingController();
  TextEditingController _controlEntre = TextEditingController();
  TextEditingController _controlCupo = TextEditingController();
  //TIME PICKER PARA TOMAR LA HORA DEL TURNO
  TimeOfDay horaselec = TimeOfDay.now();
  List<String> datosOrdenados = [];

  Future<TimeOfDay?> _horaseleccion(BuildContext context) async {
    final TimeOfDay? pick = await showTimePicker(
        context: context,
        initialTime: horaselec,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });

    if (pick != null) {
      setState(() {
        _controlHora.text = pick.format(context);
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controlDias.dispose();
    _controlHora.dispose();
    _controlCupo.dispose();
    _controlDisciplina.dispose();
    _controlEntre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre)),
        body: Center(
          child: crearWidgetPrincipal(),
        ),
      ),
    );
  }

  Widget crearWidgetPrincipal() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ingrese Disciplina',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese Disciplina';
                              }
                              return null;
                            },
                            controller: _controlDisciplina,
                            decoration: InputDecoration(
                              labelText: 'Disciplina',
                              prefixIcon: Icon(Icons.directions_walk),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese Horario';
                              }
                              return null;
                            },
                            controller: _controlHora,
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _horaseleccion(context);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Horario',
                              prefixIcon: Icon(Icons.access_time),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese Días';
                              }
                              return null;
                            },
                            controller: _controlDias,
                            readOnly: true,
                            onTap: () => {_mostrarDialogo(context)},
                            decoration: InputDecoration(
                              labelText: 'Dias',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese Cupo';
                              }
                              return null;
                            },
                            controller: _controlCupo,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Cupo',
                              prefixIcon: Icon(Icons.wc),
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Ingrese Entrenador/a';
                              }
                              return null;
                            },
                            controller: _controlEntre,
                            decoration: InputDecoration(
                              labelText: 'Entrenador/a',
                              prefixIcon: Icon(Icons.wc),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  if (!_formkey.currentState!.validate()) {
                                    return;
                                  }
                                  registrarTurno(
                                      _controlDisciplina.text,
                                      _controlHora.text,
                                      _controlDias.text,
                                      _controlCupo.text,
                                      _controlCupo.text,
                                      _controlEntre.text);
                                },
                                child: Text('Guardar Cambios'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Código',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Código',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Código',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  quitarChek(MultipleNoti prov, String a, String b) {
    prov.removerItem(a);
    prov.removerItem(b);
  }

  _mostrarDialogo(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNoti>(context);
        return AlertDialog(
          title: Text('Seleccione Días'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...dias
                      .map((e) => CheckboxListTile(
                            activeColor: Colors.amber,
                            title: Text(e),
                            onChanged: (value) {
                              value == true && e == 'Seleccionar todos'
                                  ? dias.forEach((element) {
                                      _multipleNotifier.addItem(element);
                                    })
                                  : value == true
                                      ? _multipleNotifier.addItem(e)
                                      : e == 'Seleccionar todos'
                                          ? dias.forEach((element) {
                                              _multipleNotifier
                                                  .removerItem(element);
                                            })
                                          : _multipleNotifier.itemsSeleccionados
                                                      .length ==
                                                  6
                                              ? quitarChek(_multipleNotifier,
                                                  'Seleccionar todos', e)
                                              : _multipleNotifier
                                                  .removerItem(e);
                            },
                            value: _multipleNotifier.siTieneItem(e),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
                child: Text('Ok'),
                onPressed: () => funcionOrdenar(_multipleNotifier)),
          ],
        );
      });

  funcionOrdenar(MultipleNoti pro) {
    bool testTodos = false;
    datosOrdenados.clear();
    List<String> datos = List.from(pro.itemsSeleccionados);
    if (datos.contains('Seleccionar todos')) {
      testTodos = true;
    }
    if (datos.contains('Lunes')) {
      datosOrdenados.add('Lunes');
    }
    if (datos.contains('Martes')) {
      datosOrdenados.add('Martes');
    }
    if (datos.contains('Miércoles')) {
      datosOrdenados.add('Miércoles');
    }
    if (datos.contains('Jueves')) {
      datosOrdenados.add('Jueves');
    }
    if (datos.contains('Viernes')) {
      datosOrdenados.add('Viernes');
    }
    if (testTodos) {
      datosOrdenados.clear();
      datosOrdenados.add('Todos');
    }
    _controlDias.text =
        datosOrdenados.toString().replaceAll('[', '').replaceAll(']', '');
    Navigator.of(context).pop();
  }

  Future<void> registrarTurno(
      disciplina, horario, dias, cupo, cupoalmacenado, entrenador) async {
    final turnoNuevo = Turno(
        disciplina = disciplina,
        horario = horario,
        dias = dias,
        cupo = cupo,
        cupoalmacenado = cupo,
        entrenador = entrenador);

    CollectionReference turnoNuevoReferencia =
        FirebaseFirestore.instance.collection('clientesList');

    try {
      return FirebaseFirestore.instance.runTransaction((transaction) =>
          turnoNuevoReferencia
              .doc('Gimnasios')
              .collection('Gimnasios')
              .doc(widget.pasoDatosGim!.nombre)
              .collection('Turnos')
              .doc('TurnosAdmin')
              .set(turnoNuevo.toJson())
              .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Turno almacenado con éxito')))));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocurrieron errores ' + e.toString())));
    }
  }
}
