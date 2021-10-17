import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Paginas/user_principal.dart';

class PrincipalAdmin extends StatefulWidget {
  @override
  _PrincipalAdminState createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
  String useremail;
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth != null) {
      useremail = auth.currentUser.email;
    }
    obtenerclientes(auth.currentUser).then((value) {
      if (value == 'No') {
        Navigator.of(context).pushNamed('/');
      }
    });
  }

  /* int _selectedIndex = 0;
  listado(int index) {
    List<Widget> widgetOptions = <Widget>[
      Text('Mi Turno'),
      //TabBarAdmin(),
    ];
    return widgetOptions.elementAt(index);
  }

  void _onItemTapped(int index) {
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
            label: 'Home ADMIN',
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
            IconThemeData(color: Colors.white),
            IconThemeData(color: Colors.indigoAccent.shade100),
            105.2),
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
          PersonalListTile(Icons.home, "Home ADMIN", () => {}),
          PersonalListTile(Icons.list, "Mi turno", () => {}),
          PersonalListTile(Icons.settings, "Configuración",
              () => {Navigator.of(context).pushNamed('/configAdmin')}),
          PersonalListTile(Icons.email, "Contacto", () => {}),
          PersonalListTile(Icons.phone_android, "Acerca de", () => {})
        ]),
      ),
      body: Center(
        child: Text('dadadddad'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.black,
        label: const Text('Reservar'),
        onPressed: () {},
        tooltip: 'Reservar Turno',
        splashColor: Colors.blueGrey,
        highlightElevation: 20.0,
        backgroundColor: Colors.amber.shade700,
        icon: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pantallaChica();
  }

  Future<String> obtenerclientes(User user) async {
    String admin;
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
}
