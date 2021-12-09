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
  //TIME PICKER PARA TOMAR LA HORA DEL TURNO
  TimeOfDay horaselec = TimeOfDay.now();
  String _hora = '';

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
        _hora = pick.format(context);
      });
    }
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
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _horaseleccion(context);
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Horario',
                              hintText: _hora,
                              prefixIcon: Icon(Icons.access_time),
                            ),
                          ),
                          TextFormField(
                            readOnly: true,
                            onTap: () => _mostrarDialogo(context),
                            decoration: InputDecoration(
                              labelText: 'Dias',
                              prefixIcon: Icon(Icons.date_range),
                            ),
                          ),
                          TextFormField(
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
                            //CONTINUAR ACA. FALTA DESELECCIONAR BOTON SELECCIONAR TODOS CUANDO SE
                            //APRETA ALGUN DIA EN PARTICULAR
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
                                          : _multipleNotifier.removerItem(e);
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
              onPressed: () => (print(_multipleNotifier.itemsSeleccionados)),
            ),
          ],
        );
      });
}
