import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuturnoapp/Paginas/user_principal.dart';

class PrincipalAdmin extends StatefulWidget {
  @override
  _PrincipalAdminState createState() => _PrincipalAdminState();
}

class _PrincipalAdminState extends State<PrincipalAdmin> {
  String useremail = "";
  @override
  void initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    useremail = auth.currentUser!.email!;
    obtenerclientes(auth.currentUser!).then((value) {
      if (value == 'No') {
        Navigator.of(context).pushNamed('/');
      }
    });
  }

  Widget _pantallaGrande() {
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
                          InkWell(
                            onTap: () => {},
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
                                  Text('Clientes', textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          Card(
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
                                Text('Código de Acceso', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Turnos', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Asistencias', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Pagos', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Cuotas', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Caja', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            ),
                          ),
                          Card(
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
                                Text('Notificaciones', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
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
  }

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
                      padding: const EdgeInsets.all(30.0),
                      child: GridView(
                        children: [
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Clientes', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Código de Acceso', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Turnos', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Asistencias', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Pagos', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Cuotas', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Caja', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                          Card(
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
                                    size: 30, color: Colors.white),
                                SizedBox(height: 20, width: 20),
                                Text('Notificaciones', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          ),
                        ],
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 50,
                            crossAxisSpacing: 50),
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Center(
      child: (_width > 640) ? _pantallaGrande() : _pantallaChica(),
    );
  }

  Future<String> obtenerclientes(User user) async {
    String admin = "";
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
