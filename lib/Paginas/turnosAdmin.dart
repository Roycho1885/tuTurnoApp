import 'package:flutter/material.dart';

class TurnosAdmin extends StatefulWidget {
  @override
  _TurnosAdminState createState() => _TurnosAdminState();
}

class _TurnosAdminState extends State<TurnosAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text('Estas en turnos admin'),
      ),
    );
  }
}
