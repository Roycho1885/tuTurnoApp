import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Paginas/clientes.dart';
import 'package:tuturnoapp/Paginas/turnosAdmin.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';
import 'package:tuturnoapp/Paginas/codigoAcceso.dart';

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
    return SafeArea(
      child: Scaffold(
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: new AppBarGen(nombreDelCli, widget.pasoDatosGim!.nombre),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Stack(
            children: <Widget>[
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Clientes(
                                              pasoDatosGim: widget.pasoDatosGim,
                                              nombreCli: nombreDelCli,
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/clientes.svg',
                                      width: 80,
                                    ),
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
                                              nombreCli: nombreDelCli,
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/seguridad.svg',
                                      width: 80,
                                    ),
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TurnosAdmin(
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/turnos.svg',
                                      width: 80,
                                    ),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/asistencia.svg',
                                      width: 80,
                                    ),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/pagos.svg',
                                      width: 80,
                                    ),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/cuotas.svg',
                                      width: 80,
                                    ),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/caja.svg',
                                      width: 80,
                                    ),
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                elevation: 10,
                                color: Colors.black87,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/notificaciones.svg',
                                      width: 80,
                                    ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
