import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/login_page.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Argumentos parametros = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login con Firestore'),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Esta es la pantalla principal',
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(height: 20.0),
                Text(
                  'Hola ${parametros.nombre} bienvenid@!!',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Aquín están los datos de tu cuenta: ',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Nombre: ${parametros.nombre}',
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Usuario: ${parametros.usuario}',
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Correo: ${parametros.correo}',
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Contraseña: ${parametros.password}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
        ),
      ),
      /////
    );
  }
}
