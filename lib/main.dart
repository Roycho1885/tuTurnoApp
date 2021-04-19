import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:tuturnoapp/Paginas/admin_principal.dart';
import 'package:tuturnoapp/Paginas/olvide_pass.dart';
import 'package:tuturnoapp/Paginas/registrar.dart';
import 'Paginas/user_principal.dart';
import 'Widgets/progressDialog.dart';
import 'package:flutter/services.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.indigo.shade300,
        statusBarBrightness: Brightness.dark),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'tuTurno',
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Rubik'),
      routes: {
        '/': (context) => PantallaInicial(),
        '/prinUsuario': (context) => PrincipalUsuario(),
        '/prinAdmin': (context) => PrincipalAdmin(),
        '/registro': (context) => Registrar(),
        '/olvicontra': (context) => OlvidePass(),
      },
    );
  }
}

class PantallaInicial extends StatefulWidget {
  @override
  _PantallaInicialState createState() => _PantallaInicialState();
}

class _PantallaInicialState extends State<PantallaInicial> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: DespuesDeSplash(),
      image: Image.asset('assets/images/logo.png'),
      photoSize: 80,
      loaderColor: Colors.amber.shade400,
      loadingText: Text('Cargando...'),
    );
  }
}

class DespuesDeSplash extends StatefulWidget {
  @override
  _DespuesDeSplashState createState() => _DespuesDeSplashState();
}

class _DespuesDeSplashState extends State<DespuesDeSplash> {
  TextEditingController _controlUsuario;
  TextEditingController _controlContra;
  FirebaseAuth _auth = FirebaseAuth.instance;

  _normalProgress(context) async {
    ProgressDialog pr = ProgressDialog(context: context);
    pr.show(
      max: 100,
      msg: 'Accediendo\nEspera por favor...',
      progressBgColor: Colors.amber,
    );
    await Future.delayed(Duration(seconds: 2));
    _formkey.currentState.reset();
    pr.close();
  }

  final _formkey = GlobalKey<FormState>();

  bool _ocultar = true;
  bool value = false;

  void _toogleboton() {
    setState(() {
      _ocultar = !_ocultar;
    });
  }

  @override
  void initState() {
    _controlUsuario = TextEditingController();
    _controlContra = TextEditingController();
    super.initState();
  }

  Widget _pantallaGrande() {
    return Container(
      padding: EdgeInsets.fromLTRB(200, 5, 200, 5),
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', width: 250, height: 210),
              TextFormField(
                style: TextStyle(fontSize: 18),
                enableSuggestions: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Ingrese Email';
                  }
                  if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                    return 'Por favor ingrese un email válido';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _controlUsuario,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  suffix: GestureDetector(
                    child: Icon(Icons.backspace),
                    onTap: () {
                      _controlUsuario.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                style: TextStyle(fontSize: 18),
                validator: (val) => val.isEmpty ? "Ingrese Contraseña" : null,
                controller: _controlContra,
                obscureText: _ocultar,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: _toogleboton,
                    icon: Icon(Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 260,
                height: 50,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    //ACA SE INICIA SESION AL USUARIO
                    if (_formkey.currentState.validate()) {
                      //_normalProgress(context);
                      /*showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ProgressDialog(
                              mensaje: 'Accediendo\nEspera por favor...',
                            );
                          });*/
                      login();
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 260,
                height: 50,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/registro');
                  },
                  child: Text('Registrarse'),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 200,
                height: 40,
                child: TextButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/olvicontra');
                  },
                  child: Text('¿Olvidaste tu contraseña?'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pantallaChica() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', width: 160, height: 160),
                TextFormField(
                  style: TextStyle(fontSize: 18),
                  enableSuggestions: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Ingrese Email';
                    }
                    if (!RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(value)) {
                      return 'Por favor ingrese un email válido';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _controlUsuario,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    suffix: GestureDetector(
                      child: Icon(Icons.backspace),
                      onTap: () {
                        _controlUsuario.clear();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 18),
                  validator: (val) => val.isEmpty ? "Ingrese Contraseña" : null,
                  controller: _controlContra,
                  obscureText: _ocultar,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: _toogleboton,
                      icon: Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      //ACA SE INICIA SESION AL USUARIO
                      if (_formkey.currentState.validate()) {
                        /*showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return ProgressDialog(
                                mensaje: 'Accediendo\nEspera por favor...',
                              );
                            });*/
                        login();
                      }
                    },
                    child: Text('Iniciar Sesión'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 260,
                  height: 50,
                  child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/registro');
                    },
                    child: Text('Registrarse'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 200,
                  height: 40,
                  child: TextButton(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/olvicontra');
                    },
                    child: Text('¿Olvidaste tu contraseña?'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //FUNCION LOGIN
  void login() async {
    try {
      _normalProgress(context);
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _controlUsuario.text.trim(),
              password: _controlContra.text.trim()))
          .user;
      obtenerclientes(user).then((value) {
        if (value == 'Si') {
          Navigator.of(context).pushNamed('/prinAdmin');
        } else {
          Navigator.of(context).pushNamed('/prinUsuario');
        }
      });
      // _formkey.currentState.reset();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('El email ingresado no se encuentra registrado')));
      } else {
        if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La contraseña ingresada es incorrecta')));
        } else {
          if (e.code == 'invalid-email') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Verifique que el email no contenga espacios')));
          }
        }
      }
    }
  }

//OBTENGO CLIENTES PARA SABER SI SON ADMINES
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('tu Turno'),
      ),
      body: Center(
        child: (_width > 640) ? _pantallaGrande() : _pantallaChica(),
      ),
    );
  }
}
