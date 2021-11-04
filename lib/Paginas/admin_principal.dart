import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';
import 'package:tuturnoapp/Widgets/codigoAcceso.dart';

class PrincipalAdmin extends StatefulWidget {
  final Gimnasios? pasoDatosGim;

  const PrincipalAdmin({Key? key, required this.pasoDatosGim})
      : super(key: key);
  @override
  _PrincipalAdminState createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
  String nombreDelCli = "";
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    obtenerclientes(auth.currentUser!, widget.pasoDatosGim!.nombre)
        .then((value) {
      setState(() {
        nombreDelCli = value;
      });
    });
  }

  Widget _pantallaGrande() {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.pasoDatosGim!.nombre),
              accountEmail: Text(widget.pasoDatosGim!.ubi),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(widget.pasoDatosGim!.logo),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.pasoDatosGim!.fondo),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contacto'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text('Acerca de'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: new AppBarGen(nombreDelCli, widget.pasoDatosGim!.nombre),
      body: Container(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/wave.svg',
              alignment: Alignment.topCenter,
            ),
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView(
                        children: [
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Clientes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CodigoAccesoAdmin(
                                          pasoDatosGim: widget.pasoDatosGim,
                                          nombreCli: nombreDelCli,)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.security,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Código de Acceso',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Turnos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timelapse,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Asistencias',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.attach_money_rounded,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Pagos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.payments,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Cuotas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_balance_wallet,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Caja',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.notifications,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Notificaciones',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (_width > 1000)
                                ? 4
                                : (_width > 750)
                                    ? 3
                                    : 2,
                            mainAxisSpacing: (_width > 750)
                                ? 80
                                : (_width < 750)
                                    ? 30
                                    : 20,
                            crossAxisSpacing: (_width > 750)
                                ? 80
                                : (_width < 750)
                                    ? 30
                                    : 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Widget _pantallaChica() {
    double _width = MediaQuery.of(context).size.width;
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
      body: Container(
        child: Stack(
          children: <Widget>[
            SvgPicture.network(
              'assets/images/wave.svg',
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView(
                        children: [
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Clientes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Administrar Clientes"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.security,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Código de Acceso',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Administrar Código"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Turnos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Cargar Turnos"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Eliminar Turnos"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timelapse,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Asistencias',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Registrar Asistencias"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Ver Asistencias"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.attach_money_rounded,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Pagos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Registrar Pagos"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Ver Pagos"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.payments,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Cuotas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Administrar Cuotas"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_balance_wallet,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Caja',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label: Text("Administrar Caja"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FlipCard(
                            direction: FlipDirection.VERTICAL,
                            fill: Fill.fillBack,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.notifications,
                                      size: 40, color: Colors.white),
                                  SizedBox(height: 20, width: 20),
                                  Text('Notificaciones',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              elevation: 10,
                              color: Colors.black87,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton.icon(
                                        label:
                                            Text("Administrar Notificaciones"),
                                        icon: Icon(Icons.chevron_right),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (_width > 750) ? 4 : 3,
                            mainAxisSpacing: 80,
                            crossAxisSpacing: 80),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    //double _width = MediaQuery.of(context).size.width;
    return Center(child: _pantallaGrande());
  }

  Future<String> obtenerclientes(User user, String nombregym) async {
    String nombre = "";
    await FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(nombregym)
        .collection('Clientes')
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        if (user.email == doc['email']) {
          nombre = doc['nombre'];
        }
      });
    });
    return nombre;
  }
}
