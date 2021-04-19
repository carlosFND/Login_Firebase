import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TextEditingController nombreTextController;
  //TextEditingController apellidoTextController;
  User usu = User();
  FocusNode userFocus, passwordFocus;
  String user;
  String password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login con Firestore'),
          backgroundColor: Colors.cyan.shade800,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                      labelText: 'Usuario',
                    ),
                    onSaved: (value) {
                      user = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: userFocus,
                    onEditingComplete: () {
                      requestFocus(context, passwordFocus);
                    },
                    textInputAction: TextInputAction.next,
                    //controller: nombreTextController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        labelText: 'Password'),
                    onSaved: (value) {
                      password = value;
                    },
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Este campo no puede estar vacio';
                      } else {
                        return null;
                      }
                    },
                    focusNode: passwordFocus,
                    onEditingComplete: () {
                      envioFormulario();
                    },
                    //controller: apellidoTextController,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    width: 360.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.cyanAccent.shade700,
                      textColor: Colors.white,
                      onPressed: () {
                        envioFormulario();
                      },
                      child: Text('Enviar',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 360.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, 'registro');
                      },
                      child: Text('Aún no tengo cuenta',
                          style: TextStyle(
                            fontSize: 14.0,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void envioFormulario() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      int respuesta = await validarUsuario();
      print('respuesta obtenida ' + respuesta.toString());

      if (respuesta == 1) {
        Navigator.pushNamed(context, 'principal',
            arguments: Argumentos(
                usuario: usu.getUsuario,
                password: usu.getPassword,
                correo: usu.getCorreo,
                nombre: usu.getNombre));
      } else {
        showDialog(
            context: context,
            builder: (buildercontext) {
              return AlertDialog(
                title: Text('El usuario y/o contraseña son incorrectos'),
                content:
                    Text('Verifica tus datos registrate si no lo has echo'),
                actions: [
                  // ignore: deprecated_member_use
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Cerrar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  final firebaseInstance = FirebaseFirestore.instance;
  Future<int> validarUsuario() {
    int respuesta;
    firebaseInstance
        .collection('Usuarios')
        .where('usuario', isEqualTo: user)
        .where('password', isEqualTo: password)
        .snapshots()
        .listen((result) {
      result.docs.forEach((doc) {
        print('estos son los datos:');
        print(doc.data());
        var userData = doc.data();

        usu.usuario = userData['usuario'];
        usu.password = userData['password'];
        usu.correo = userData['correo'];
        usu.nombre = userData['nombre'];
      });
    });

    print('Estos son los datos del Usuario: ');
    print(usu.getUsuario);
    print(usu.getPassword);

    if (usu.getUsuario == user && usu.getPassword == password) {
      respuesta = 1;
      print('Esta es la Respuesta= ' + respuesta.toString());
    }

    return Future.delayed(new Duration(seconds: 1), () {
      return respuesta;
    });
  }

  ////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();
    userFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    userFocus.dispose();
    passwordFocus.dispose();
  }
}

class Argumentos {
  String usuario, password, correo, nombre;

  Argumentos({this.usuario, this.password, this.correo, this.nombre});
}
