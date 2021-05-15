import 'package:flutter/material.dart';

class TabBarAdmin extends StatefulWidget {
  @override
  _TabBarAdminState createState() => _TabBarAdminState();
}

class _TabBarAdminState extends State<TabBarAdmin> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    if (_width > 640) {
      return _pantallaGrande();
    } else {
      return _pantallaChica();
    }
  }

  Widget _pantallaGrande() {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: "Alumnos", icon: Icon(Icons.perm_identity_outlined)),
              Tab(text: "Código de Acceso", icon: Icon(Icons.lock)),
              Tab(text: "Agregar Turnos", icon: Icon(Icons.check)),
              Tab(text: "Eliminar Turnos", icon: Icon(Icons.close)),
              Tab(text: "Cuotas", icon: Icon(Icons.attach_money)),
              Tab(text: "Notificaciones", icon: Icon(Icons.notifications))
            ],
          ),
          title: Text("Configuración"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(50),
            child: TabBarView(
              children: [
                Icon(Icons.flight),
                _codigoingreso(),
                Icon(
                  Icons.train,
                  size: 150,
                ),
                Icon(
                  Icons.flight,
                  size: 150,
                ),
                Icon(
                  Icons.gamepad,
                  size: 150,
                ),
                Icon(
                  Icons.dashboard_outlined,
                  size: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pantallaChica() {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(icon: Icon(Icons.perm_identity_outlined)),
              Tab(icon: Icon(Icons.lock)),
              Tab(icon: Icon(Icons.check)),
              Tab(icon: Icon(Icons.close)),
              Tab(icon: Icon(Icons.attach_money)),
              Tab(icon: Icon(Icons.notifications))
            ],
          ),
          title: Text("Configuración"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(50),
            child: TabBarView(
              children: [
                Icon(Icons.flight),
                _codigoingreso(),
                Icon(
                  Icons.train,
                  size: 150,
                ),
                Icon(
                  Icons.flight,
                  size: 150,
                ),
                Icon(
                  Icons.gamepad,
                  size: 150,
                ),
                Icon(
                  Icons.dashboard_outlined,
                  size: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _codigoingreso() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Ingrese nuevo código',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 6,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            labelText: 'Código',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 20),
        Text('Código Actual'),
        SizedBox(height: 5),
        Text('123456'),
        SizedBox(height: 50),
        Container(
          height: 50,
          width: 260,
          child: ElevatedButton(
            child: Text('Aceptar'),
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
