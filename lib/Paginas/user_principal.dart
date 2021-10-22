import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrincipalUsuario extends StatefulWidget {
  @override
  _PrincipalUsuarioState createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {
  String useremail="";
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    useremail = auth.currentUser!.email!;
    obtenerclientes(auth.currentUser!).then((value) {
      if (value == 'Si') {
        Navigator.of(context).pushNamed('/');
      }
    });
  }

  //INPUT DE FECHA
  DateTime _date = DateTime.now();
  String _fecha="";

  Future<Null> _selecFecha(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: _date.weekday == 7
          ? DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
          : _date,
      //initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      selectableDayPredicate: (DateTime val) => val.weekday == 7 ? false : true,
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        _fecha = new DateFormat.yMMMMEEEEd('es_ES').format(_date).toString();
      });
    }
  }

  //WIDGET PEDIR TURNO
  Widget pedirturno() {
    double _width = MediaQuery.of(context).size.width;
    if (_width > 640) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(200, 20, 200, 50),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                setState(() {
                  _selecFecha(context);
                });
              },
              decoration: InputDecoration(
                  labelText: 'Seleccione Fecha', hintText: _fecha),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 50, 100),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                setState(() {
                  _selecFecha(context);
                });
              },
              decoration: InputDecoration(
                  labelText: 'Seleccione Fecha', hintText: _fecha),
            ),
          ),
        ],
      );
    }
  }

  listado(int index) {
    List<Widget> widgetOptions = <Widget>[
      pedirturno(),
      Text('Mi Turno'),
    ];
    return widgetOptions.elementAt(index);
  }

  /* void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _pantallaGrande() {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              tooltip: 'Cerrar Sesión',
              icon: Icon(
                Icons.logout,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
              }),
        ],
        title: Text('Bienvenido ' + useremail),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home USUARIO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Mi Turno',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Contacto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: 'Acerca de',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 25,
        unselectedIconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.amberAccent),
            IconThemeData(color: Colors.blue.shade800),
            20),
        selectedItemColor: Colors.amber,
        iconSize: 30,
        onTap: _onItemTapped,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.black,
                        Colors.indigo,
                        Colors.indigoAccent
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Image.asset(
                          'assets/images/logogris.png',
                          width: 110,
                          height: 110,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'tu Turno App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                listado(_selectedIndex),
                //widgetOptions.elementAt(_selectedIndex),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        splashColor: Colors.blueGrey,
        highlightElevation: 20.0,
        tooltip: 'Reservar Turno',
        label: const Text('Reservar'),
        onPressed: () {},
        icon: const Icon(Icons.add),
        backgroundColor: Colors.amber.shade700,
      ),
    );
  }*/

  Widget _pantallaChica() {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              tooltip: 'Cerrar Sesión',
              icon: Icon(
                Icons.logout,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/');
              }),
        ],
        leadingWidth: 25,
        title: Text('Bienvenido ' + useremail),
      ),
      drawer: new Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
              Colors.black,
              Colors.indigo,
              Colors.indigoAccent
            ])),
            child: Container(
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Image.asset('assets/images/logogris.png',
                          width: 90, height: 90),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text('tu Turno App',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ],
              ),
            ),
          ),
          /* PersonalListTile(Icons.home, "Home USUARIO", () => {}),
          PersonalListTile(Icons.list, "Mi turno", () => {}),
          PersonalListTile(Icons.settings, "Configuración", () => {}),
          PersonalListTile(Icons.email, "Contacto", () => {}),
          PersonalListTile(Icons.phone_android, "Acerca de", () => {}) */
        ]),
      ),
      body: Center(
        child: listado(0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Reservar Turno',
        splashColor: Colors.blueGrey,
        highlightElevation: 20.0,
        backgroundColor: Colors.amber.shade700,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pantallaChica();
  }
}

Future<String> obtenerclientes(User user) async {
  String admin="";
  await FirebaseFirestore.instance
      .collection('clientesPrincipal')
      .doc('Clientes')
      .collection('Clientes')
      .get()
      .then((QuerySnapshot query) {
    query.docs.forEach((doc) {
      if (user.email == doc['email']) {
        admin = doc['admin'];
      }
    });
  });
  return admin;
}

// ignore: must_be_immutable
class PersonalListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  PersonalListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.blueGrey,
          onTap: onTap(),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
