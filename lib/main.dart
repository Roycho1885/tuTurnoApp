import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tuturnoapp/Paginas/registrar.dart';
import 'Paginas/user_principal.dart';
import 'Widgets/progressDialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tuTurno',
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Rubik'),
      routes: {
        '/': (context) => PantallaInicial(),
        '/prinUsuario': (context) => PrincipalUsuario(),
        '/registro': (context) => Registrar(),
      },
    );
  }
}

class PantallaInicial extends StatefulWidget {
  @override
  _PantallaInicialState createState() => _PantallaInicialState();
}

class _PantallaInicialState extends State<PantallaInicial> {
  TextEditingController _controlUsuario;
  TextEditingController _controlContra;
  FirebaseAuth _auth = FirebaseAuth.instance;

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
              Container(
                margin: EdgeInsets.fromLTRB(50, 10, 50, 20),
                child: crearCheck(),
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
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ProgressDialog(
                              mensaje: 'Accediendo\nEspera por favor...',
                            );
                          });
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
                  onPressed: () {},
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
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 20),
                  child: crearCheck(),
                ),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 90),
                  ),
                  onPressed: () {
                    //ACA SE INICIA SESION AL USUARIO
                    if (_formkey.currentState.validate()) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return ProgressDialog(
                              mensaje: 'Accediendo\nEspera por favor...',
                            );
                          });
                      login();
                    }
                  },
                  child: Text('Iniciar Sesión'),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 90),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/registro');
                  },
                  child: Text('Registrarse'),
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
                    onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('tuTurno'),
      ),
      body: Center(
        child: (_width > 640) ? _pantallaGrande() : _pantallaChica(),
      ),
    );
  }

//ESTE ES EL CHECKBOX COACH
  Widget crearCheck() => CheckboxListTile(
      title: Text('Ingreso Admin'),
      value: value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      });

  //FUNCION LOGIN
  void login() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: _controlUsuario.text, password: _controlContra.text))
          .user;

      Navigator.pop(context);
      Navigator.of(context).pushNamed('/prinUsuario');

      _formkey.currentState.reset();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
}
