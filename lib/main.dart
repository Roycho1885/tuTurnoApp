import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Paginas/admin_principal.dart';
import 'package:tuturnoapp/Paginas/olvide_pass.dart';
import 'package:tuturnoapp/Paginas/registrar.dart';
import 'package:tuturnoapp/Paginas/codigoAcceso.dart';
import 'package:tuturnoapp/Widgets/progressDialog.dart';
import 'Paginas/user_principal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.black,
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
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 2460,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'),
      ],
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      title: 'tuTurno',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      routes: {
        '/': (context) => PantallaInicial(),
        '/prinUsuario': (context) => PrincipalUsuario(),
        '/prinAdmin': (context) => PrincipalAdmin(
              pasoDatosGim: null,
            ),
        '/registro': (context) => Registrar(),
        '/olvicontra': (context) => OlvidePass(),
        '/codigoAccesoAdmin': (context) => CodigoAccesoAdmin(
              pasoDatosGim: null,
              nombreCli: '',
            ),
        '/login': (context) => PantallaLogin(),
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
    return new SplashScreenView(
      navigateRoute: DespuesDeSplash(),
      duration: 3000,
      imageSrc: 'assets/images/tuturnoicon.png',
      imageSize: 180,
    );
  }
}

class DespuesDeSplash extends StatefulWidget {
  @override
  _DespuesDeSplashState createState() => _DespuesDeSplashState();
}

class _DespuesDeSplashState extends State<DespuesDeSplash> {
  TextEditingController _busquedaControl = TextEditingController();

  late Future resultCargados;
  List _todosLosResult = [];
  List listaResultados = [];

  getGimnasiosStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .get();
    setState(() {
      _todosLosResult = data.docs;
    });
    busquedaResultLista();
    return "Completado";
  }

  @override
  void initState() {
    super.initState();
    _busquedaControl.addListener(_onBusquedaCambio);
  }

  @override
  void dispose() {
    _busquedaControl.removeListener(_onBusquedaCambio);
    _busquedaControl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultCargados = getGimnasiosStreamSnapshots();
  }

  _onBusquedaCambio() {
    busquedaResultLista();
  }

  busquedaResultLista() {
    var mostrarResultados = [];

    if (_busquedaControl.text != "") {
      for (var gimSnap in _todosLosResult) {
        var title = Gimnasios.fromSnapshot(gimSnap).nombre.toLowerCase();

        if (title.contains(_busquedaControl.text.toLowerCase())) {
          mostrarResultados.add(gimSnap);
        }
      }
    } else {
      mostrarResultados = List.from(_todosLosResult);
    }
    setState(() {
      listaResultados = mostrarResultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('tu Turno'),
        ),
        body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: (value) {},
                controller: _busquedaControl,
                decoration: InputDecoration(
                  labelText: "Buscar",
                  hintText: "Buscar",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Selecciona tu gimnasio",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listaResultados.length,
              itemBuilder: (BuildContext context, int index) =>
                  crearListaCard(context, listaResultados[index]),
            )),
          ]),
        ));
  }
}

Widget crearListaCard(BuildContext context, DocumentSnapshot document) {
  final gimdatos = Gimnasios.fromSnapshot(document);

  return new Container(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 10,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    child: Image.network(
                      gimdatos.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gimdatos.nombre,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        gimdatos.ubi,
                        style: TextStyle(fontSize: 15, color: Colors.black38),
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PantallaLogin(),
                  settings: RouteSettings(arguments: gimdatos)));
        },
      ),
    ),
  );
}

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({Key? key}) : super(key: key);
  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  late TextEditingController _controlUsuario;
  late TextEditingController _controlContra;
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
    final gimdatos = ModalRoute.of(context)!.settings.arguments as Gimnasios;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/fondo.png'), fit: BoxFit.cover)),
      child: Form(
        key: _formkey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    gimdatos.logo,
                    width: 140,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          enableSuggestions: true,
                          validator: (value) {
                            if (value!.isEmpty) {
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
                              suffixIcon: IconButton(
                                onPressed: _controlUsuario.clear,
                                icon: Icon(Icons.clear),
                              )),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          style: TextStyle(fontSize: 18),
                          validator: (val) =>
                              val!.isEmpty ? "Ingrese Contraseña" : null,
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
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          //ACA SE INICIA SESION AL USUARIO
                          if (_formkey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return ProgressDialog(
                                    mensaje: 'Accediendo...',
                                  );
                                });
                            login(gimdatos);
                          }
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registrar(),
                                  settings:
                                      RouteSettings(arguments: gimdatos)));
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Registrarse',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/olvicontra');
                        },
                        child: Text('¿Olvidaste tu contraseña?'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FUNCION LOGIN
  void login(Gimnasios datosGim) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: _controlUsuario.text.trim(),
              password: _controlContra.text.trim()))
          .user;
      obtenerclientes(user!, datosGim.nombre).then((value) {
        if (value == 'Si') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PrincipalAdmin(pasoDatosGim: datosGim)));
        } else {
          if (value == "") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('No se encuentra registrado en este gimnasio')));
          } else {
            Navigator.of(context).pushNamed('/prinUsuario');
          }
        }
      });
      _formkey.currentState!.reset();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('El email ingresado no se encuentra registrado')));
        Navigator.pop(context);
      } else {
        if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La contraseña ingresada es incorrecta')));
          Navigator.pop(context);
        } else {
          if (e.code == 'invalid-email') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Verifique que el email no contenga espacios')));
            Navigator.pop(context);
          }
        }
      }
    }
  }

  //OBTENGO CLIENTES PARA SABER SI SON ADMINES
  Future<String> obtenerclientes(User user, String nombregym) async {
    String admin = "";
    await FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(nombregym)
        .collection('Clientes')
        .get()
        .then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        if (user.email == doc['email'] && doc['nombregym'] == nombregym) {
          admin = doc['admin'];
        }
      });
    });
    return admin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pantallaGrande()),
    );
  }
}
