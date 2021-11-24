import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                                _abrirPopUpPerfilAdmin(context, nombreDelGym);
                              },
                              label: Text('Mi Perfil'),
                              icon: Icon(Icons.person)),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
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

getUsuarios(String nombreGym) {
  return FirebaseFirestore.instance
      .collection('clientesList')
      .doc('Gimnasios')
      .collection('Gimnasios')
      .doc(nombreGym)
      .collection('Clientes')
      .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots();
}

_abrirPopUpPerfilAdmin(context, String nombreGim) {
  Alert(
      context: context,
      title: "Mi Perfil",
      content: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: getUsuarios(nombreGim),
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
            return Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: data['nombre'],
                  ),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
              ],
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
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
