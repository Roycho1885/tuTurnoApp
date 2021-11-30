import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuturnoapp/Paginas/perfilAdmin.dart';

/* final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
TextEditingController _controlNombre = TextEditingController();
TextEditingController _controlApellido = TextEditingController();
TextEditingController _controlDni = TextEditingController();
TextEditingController _controlDire = TextEditingController();
TextEditingController _controlTele = TextEditingController();
final color = Colors.indigo;
var mascara = new MaskTextInputFormatter(
    mask: '+54 ###### - ####', filter: {'#': RegExp(r'[0-9]')});
late String _nombre;
late String _apellido;
late String _dni;
late String _direccion;
late String _telefono; */

// ignore: must_be_immutable
class AppBarGen extends AppBar {
  AppBarGen(String? nombreDelCli, String? nombreDelGym, {Key? key})
      : super(
          key: key,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombreDelGym!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Hola ' + nombreDelCli!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: PopupMenuButton(
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed: () {
                                User? user = FirebaseAuth.instance.currentUser;
                                obtenerclientes(user!, nombreDelGym)
                                    .then((value) =>{
                                      Navigator.of(context).pop(),
                                      Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PerfilAdministrador(
                                              nombreGym: nombreDelGym,
                                              nombreCli: nombreDelCli,
                                              idDoc : value,
                                            )))
                                    });
                                
                              },
                              label: Text('Mi Perfil'),
                              icon: Icon(Icons.person)),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/');
                            },
                            icon: Icon(Icons.logout),
                            label: Text('Cerrar Sesión'),
                          ),
                        ),
                      ]),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Color(0x041E47), Colors.black54],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        );
}

//OBTENGO EL ID DEL DOCUMENTO ADMIN QUE ESTA LOGEADO
Future<String> obtenerclientes(User user, String nombregym) async {
  String idCliente = "";
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
        idCliente = doc.id;
      }
    });
  });
  return idCliente;
}


/* 

//ALERTA DONDE ESTA EL FORM CON LOS DATOS DEL ADMINISTRADOR
_abrirPopUpPerfilAdmin(context, String nombreGim) {
  obtenerclientes(user!, nombreGim).then((value) {
    Alert(
        context: context,
        content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: getUsuarios(nombreGim, value),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Algo anda mal...Reintenta');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
            if (snapshot.hasData) {
              var data = snapshot.data!;
              _controlNombre.text = data['nombre'];
              _controlApellido.text = data['apellido'];
              _controlDni.text = data['dni'];
              _controlDire.text = data['direccion'];
              _controlTele.text = data['telefono'];
              return Form(
                child: Column(
                  children: <Widget>[
                    consTop(data['imgperfil']),
                    consContenido(data['nombre'], data['email']),
                    SizedBox(height: 10),
                    _crearCampoNombre(),
                    _crearCampoApellido(),
                    _crearCampoDni(),
                    _crearCampoDireccion(),
                    _crearCampoTelefono()
                  ],
                ),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          },
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Guardar Cambios",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  });
} */

/* File? _imagen;
final _picker = ImagePicker();
var imgValor;
Future getImagenDeGaleria() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  final File imagen = File(pickedFile!.path);

  setState(() {
    _imagen = imagen;
    print('Imagen direccion $_imagen');
  });
}

*/

/* Widget consContenido(String nombre, String email) {
  return Column(
    children: [
      SizedBox(height: 8),
      Text(
        nombre,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 2),
      Text(
        email,
        style: TextStyle(fontSize: 16, color: Colors.black38),
      ),
    ],
  );
}

Widget consTop(String imgperfil) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(padding: EdgeInsets.all(30)),
      Positioned(child: imagenPerfil(imgperfil)),
    ],
  );
}

Widget imagenPerfil(String imagen) {
  return Stack(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(imagen),
      ),
      Positioned(
        bottom: 0,
        right: 4,
        child: crearIconoFoto(),
      ),
    ],
  );
}

Widget crearIconoFoto() {
  return crearIconoFotoSeg(
    color: Colors.white,
    all: 3,
    child: crearIconoFotoSeg(
      color: Colors.indigo,
      all: 8,
      child: InkWell(
        onTap: () {
        },
        child: Icon(Icons.edit, size: 15, color: Colors.white),
      ),
    ),
  );
}

Widget crearIconoFotoSeg(
        {required Widget child, required double all, required Color color}) =>
    ClipOval(
      child:
          Container(padding: EdgeInsets.all(all), child: child, color: color),
    );
 */