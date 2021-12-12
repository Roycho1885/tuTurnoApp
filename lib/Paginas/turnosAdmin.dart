import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
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
  TextEditingController _controlDias = TextEditingController();
  TextEditingController _controlHora = TextEditingController();
  //TIME PICKER PARA TOMAR LA HORA DEL TURNO
  TimeOfDay horaselec = TimeOfDay.now();
  String _hora = '';
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

  /* Widget crearWidgetCheckBox(CheckboxState check) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.amber,
      value: check.value,
      title: Text(check.titulo, style: TextStyle(fontWeight: FontWeight.bold)),
      onChanged: (value) {
        setState(() {
          check.value = value!;
        });
      },
    );
  }

  Future<void> mostrarDialogo(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    ...diasSemana.map(crearWidgetCheckBox).toList(),
                  ],
                ),
              ),
            );
          });
        });
  } */

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ingrese Disciplina',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Disciplina',
                              prefixIcon: Icon(Icons.directions_walk),
                            ),
                          ),
                          TextFormField(
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
                          TextFormField(
                            controller: _controlDias,
                            readOnly: true,
                            onTap: () => {_mostrarDialogo(context)},
                            decoration: InputDecoration(
                              labelText: 'Dias',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                          ),
                          TextFormField(
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Entrenador/a',
                              prefixIcon: Icon(Icons.wc),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
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
}
