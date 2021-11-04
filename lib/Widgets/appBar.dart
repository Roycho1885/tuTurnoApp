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
            PopupMenuButton(
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
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/tuturno-91997.appspot.com/o/FondoClientes%2Ffondo.jpg?alt=media&token=3f00d050-6966-432b-b164-78ddb6f9ccc8')),
            ),
          ),
        );
}
