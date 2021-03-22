import 'package:flutter/material.dart';

class PrincipalUsuario extends StatefulWidget {
  @override
  _PrincipalUsuarioState createState() => _PrincipalUsuarioState();
}

class _PrincipalUsuarioState extends State<PrincipalUsuario> {
  Widget _pantallaGrande() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Usuario'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
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
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Image.asset(
                        'assets/images/logogris.png',
                        width: 140,
                        height: 140,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text('tu Turno App',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 250,
                height: 300,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    PersonalListTile(Icons.home, "Home", () => {}),
                    PersonalListTile(Icons.list, "Mi turno", () => {}),
                    PersonalListTile(Icons.settings, "Configuración", () => {}),
                    PersonalListTile(Icons.email, "Contacto", () => {}),
                    PersonalListTile(Icons.phone_android, "Acerca de", () => {})
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pantallaChica() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Usuario'),
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
          PersonalListTile(Icons.home, "Home", () => {}),
          PersonalListTile(Icons.list, "Mi turno", () => {}),
          PersonalListTile(Icons.settings, "Configuración", () => {}),
          PersonalListTile(Icons.email, "Contacto", () => {}),
          PersonalListTile(Icons.phone_android, "Acerca de", () => {})
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    if (_width > 640) {
      return _pantallaGrande();
    } else {
      return _pantallaChica();
    }
  }
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
          splashColor: Colors.indigoAccent,
          onTap: onTap,
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
