import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tuturnoapp/Modelo/Gimnasios.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBarGen(widget.nombreCli, widget.pasoDatosGim!.nombre)),
      body: Center(
        child: construirCuerpoListado(context),
      ),
    );
  }

  getUsuarios() {
    return FirebaseFirestore.instance
        .collection('clientesList')
        .doc('Gimnasios')
        .collection('Gimnasios')
        .doc(widget.pasoDatosGim!.nombre)
        .collection('Clientes')
        .snapshots();
  }

  Widget construirCuerpoListado(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsuarios(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              //SLIDABLE PARA MODIFICAR O ELIMINAR CLIENTES
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                elevation: 10,
                child: InkWell(
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    actions: [
                      IconSlideAction(
                        caption: 'Ver/Modificar',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: () {},
                      ),
                    ],
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Borrar',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {},
                      ),
                    ],
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(data['apellido'] + ' ' + data['nombre']),
                      subtitle: Text(data['email']),
                    ),
                  ),
                  onTap: (){},
                ),
              );
            }).toList(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
