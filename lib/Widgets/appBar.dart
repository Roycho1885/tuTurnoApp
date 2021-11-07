import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                              onPressed: () {},
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
