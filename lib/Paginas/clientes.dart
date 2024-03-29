import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tuturnoapp/Modelo/Cliente.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
import 'package:tuturnoapp/Paginas/perfilClientes.dart';
import 'package:tuturnoapp/Widgets/alertDialog.dart';
import 'package:tuturnoapp/Widgets/appBar.dart';

class Clientes extends StatefulWidget {
  final Gimnasios? pasoDatosGim;
  final String? nombreCli;
  //CONSTANTE PARA PASO DE ARGUMENTOS
  const Clientes(
      {Key? key, required this.pasoDatosGim, required this.nombreCli})
      : super(key: key);
  @override
  _Clientes createState() => _Clientes();
}

class _Clientes extends State<Clientes> {
  String nombreCli = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre)),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      nombreCli = value;
                    });
                  },
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
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: construirCuerpoListado(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  getUsuariosBusqueda() {
    return FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(widget.pasoDatosGim!.nombre)
        .collection('Clientes')
        .where('admin', isEqualTo: 'No')
        .where('apellido', isGreaterThanOrEqualTo: nombreCli)
        .orderBy('apellido')
        .snapshots();
  }

  getUsuarios() {
    return FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(widget.pasoDatosGim!.nombre)
        .collection('Clientes')
        .where('admin', isEqualTo: 'No')
        .snapshots();
  }

  borrarCliente(Cliente cli) {
    FirebaseFirestore.instance.runTransaction((Transaction trans) async {
      trans.delete(cli.referencia!);
    });
  }

  Widget construirCuerpoListado(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: (nombreCli != '' && nombreCli != null)
          ? getUsuariosBusqueda()
          : getUsuarios(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
        if (snapshot.data!.docs.length == 0) {
          return Container(
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/images/sindatos.svg'),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data!.docs[index];
                final clienteDatos = Cliente.fromSnapshot(data);
                //SLIDABLE PARA MODIFICAR O ELIMINAR CLIENTES
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  elevation: 10,
                  child: InkWell(
                    //SLIDABLE PARA MODIFICAR O ELIMINAR CLIENTES
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: [
                        IconSlideAction(
                          caption: 'Ver/Modificar',
                          color: Colors.blue,
                          icon: Icons.edit,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PerfilClientes(
                                          cliente: clienteDatos,
                                          nombreCli: widget.nombreCli,
                                          pasoDatosGim: widget.pasoDatosGim,
                                        )));
                          },
                        ),
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Borrar',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            _dialogoAlerta(context, clienteDatos);
                          },
                        ),
                      ],
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: ClipOval(
                                child: Image.network(data['imgperfil'], fit: BoxFit.fill),
                            )),
                        title: Text(
                          data['apellido'] + ' ' + data['nombre'],
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          data['email'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
        return Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );
  }

  _dialogoAlerta(BuildContext context, Cliente clidatos) {
    VoidCallback contCallBack = () => {
          borrarCliente(clidatos),
          Navigator.of(context).pop(),
        };

    AlertaDialogo alerta = AlertaDialogo(
        "¡Atención!", "Seguro que quieres eliminar este cliente", contCallBack);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        });
  }
}
